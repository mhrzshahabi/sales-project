package com.nicico.sales.aop;

import com.google.common.base.Enums;
import com.google.common.base.Optional;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.enumeration.AllConverters;
import com.nicico.sales.model.enumeration.CommercialRole;
import com.nicico.sales.model.enumeration.EStatus;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.modelmapper.ModelMapper;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import static com.nicico.copper.common.domain.criteria.SearchUtil.createSearchRq;
import static com.nicico.copper.common.domain.criteria.SearchUtil.mapSearchRs;

@Aspect
@Order(3)
@Component
@RequiredArgsConstructor
public class CriteriaRefinerAspect {

    private final ModelMapper modelMapper;

    @Around(value = "" +
            "(execution(* com.nicico.sales.service.GenericService+.search(..)) && args(request)) || " +
            "(@annotation(com.nicico.sales.annotation.CheckCriteria) && args(request))")
    public TotalResponse<? extends Object> refineDateCriteria(ProceedingJoinPoint proceedingJoinPoint, NICICOCriteria request) throws Throwable {

        Object target = proceedingJoinPoint.getTarget();
        if (target == null) return (TotalResponse<?>) proceedingJoinPoint.proceed();

        ParameterizedType superClass = (ParameterizedType) target.getClass().getGenericSuperclass();
        Class<?> entityClass = (Class<?>) superClass.getActualTypeArguments()[0];
        SearchDTO.SearchRq newRequest = createSearchRq(request);
        boolean check = checkSort(newRequest, entityClass);
        check |= checkCriteria(newRequest.getCriteria(), entityClass);
        if (check) {

            final String searchMethodName = ((MethodSignature) proceedingJoinPoint.getSignature()).getMethod().getName();
            final Method searchMethod = target.getClass().getMethod(searchMethodName, SearchDTO.SearchRq.class);
            return mapSearchRs(request, (SearchDTO.SearchRs<?>) searchMethod.invoke(target, newRequest));
        } else return (TotalResponse<?>) proceedingJoinPoint.proceed();
    }

    private Field getField(String fieldName, Class<?> entityClass) {

        String propertyPostfix = "";
        Field field = ReflectionUtils.findField(entityClass, fieldName);
        I18n[] i18ns = Objects.requireNonNull(field).getAnnotationsByType(I18n.class);
        if (i18ns.length > 0) {

            Locale locale = LocaleContextHolder.getLocale();
            propertyPostfix = locale.getLanguage().equals(Locale.ENGLISH.getLanguage()) ? "EN" : "FA";
            field = ReflectionUtils.findField(entityClass, fieldName + propertyPostfix);
        }

        return field;
    }

    private Class<?> getFieldType(Field field) {

        if (field.getType().isAssignableFrom(List.class) || field.getType().isAssignableFrom(Set.class))
            return (Class) ((ParameterizedType) field.getGenericType()).getActualTypeArguments()[0];

        return field.getType();
    }

    private Field getFieldByNames(String fieldName, Class<?> entityClass) {

        final String[] fieldNames = fieldName.split("\\.");
        Field field = getField(fieldNames[0], entityClass);
        for (int i = 1; i < fieldNames.length; i++)
            field = getField(fieldNames[i], getFieldType(field));

        return field;
    }

    private String refineFieldName(String fieldName, Class<?> entityClass) {

        final String[] fieldNames = fieldName.split("\\.");
        Field field = getField(fieldNames[0], entityClass);
        StringBuilder result = new StringBuilder(field.getName());
        for (int i = 1; i < fieldNames.length; i++) {

            field = getField(fieldNames[i], getFieldType(field));
            result.append(".").append(field.getName());
        }

        return result.toString();
    }

    private String refineEStatusField(String fieldName, SearchDTO.CriteriaRq criteriaRq) {

        fieldName = fieldName.replaceAll("\\b" + "estatus" + "\\b", "eStatusId");
        criteriaRq.setFieldName(fieldName);
        if (criteriaRq.getValue().size() > 1 && (criteriaRq.getOperator() == EOperator.contains || criteriaRq.getOperator() == EOperator.iContains)) {

            criteriaRq.setFieldName(null);
            criteriaRq.setOperator(EOperator.or);
            ArrayList<SearchDTO.CriteriaRq> criteriaRqs = new ArrayList<>();
            for (Object value : criteriaRq.getValue()) {

                Optional<EStatus> statusOptional = Enums.getIfPresent(EStatus.class, value + "");
                if (statusOptional.isPresent()) {

                    criteriaRqs.add(new SearchDTO.CriteriaRq().setFieldName(fieldName).setOperator(EOperator.equals).setValue(statusOptional.get()));
                }
            }
            criteriaRq.setValue(null);
            criteriaRq.setCriteria(criteriaRqs);
        } else {

            List<EStatus> statuses = new ArrayList<>();
            for (Object value : criteriaRq.getValue()) {

                Optional<EStatus> statusOptional = Enums.getIfPresent(EStatus.class, value + "");
                if (statusOptional.isPresent()) statuses.add(statusOptional.get());
            }
            criteriaRq.setValue(new AllConverters.EStatusSetConverter().convertToDatabaseColumn(statuses));
        }

        return fieldName;
    }

    private boolean makeContractContactsCriteria(SearchDTO.CriteriaRq criteriaRq, String fieldName) {

        Integer roleId = null;
        switch (fieldName) {
            case "buyerId":
                roleId = CommercialRole.Buyer.getId();
                break;
            case "sellerId":
                roleId = CommercialRole.Seller.getId();
                break;
            case "agentBuyerId":
                roleId = CommercialRole.AgentBuyer.getId();
                break;
            case "agentSellerId":
                roleId = CommercialRole.AgentSeller.getId();
                break;
        }

        if (roleId != null) {

            SearchDTO.CriteriaRq newCriteriaRq = new SearchDTO.CriteriaRq();
            modelMapper.map(criteriaRq, newCriteriaRq);

            newCriteriaRq.setOperator(EOperator.equals);
            newCriteriaRq.setFieldName("contractContacts.contactId");

            SearchDTO.CriteriaRq roleCriteriaRq = new SearchDTO.CriteriaRq().
                    setFieldName("contractContacts.commercialRole").
                    setOperator(EOperator.equals).
                    setValue(roleId);

            criteriaRq.setFieldName(null).
                    setOperator(EOperator.and).
                    setValue(null).
                    setCriteria(Arrays.asList(roleCriteriaRq, newCriteriaRq)).
                    setStart(null).
                    setEnd(null);

            return true;
        }

        return false;
    }

    private boolean refineDateField(String fieldName, SearchDTO.CriteriaRq criteriaRq, boolean result) {

        List<Date> newValues = new ArrayList<>();
        final List<Object> values = criteriaRq.getValue();
        for (Object value : values)
            if (value instanceof Date) newValues.add((Date) value);
            else if (value instanceof String) {

                result = true;

                String date = String.valueOf(value);
                if (date.length() <= 10) {

                    if (criteriaRq.getOperator() == EOperator.lessOrEqual) date += " 23:59:59";
                    else date += " 00:00:00";
                }

                newValues.add(new Date(date.replace('-', '/')));
            } else if (value instanceof Map)
                throw new SalesException2(ErrorType.BadRequest, fieldName, "فیلتر مورد نظر پشتیبانی نمی شود.");
            else throw new SalesException2(ErrorType.BadRequest, fieldName, "فیلتر مورد نظر اشتباه میباشد.");

        criteriaRq.setValue(newValues);
        return result;
    }

    private boolean checkSort(SearchDTO.SearchRq searchRq, Class<?> entityClass) {

        final boolean[] result = {false};
        List<SearchDTO.SortByRq> sortByRqs = searchRq.getSortBy();
        if (sortByRqs != null) {

            List<String> sortBys = new ArrayList<>();
            sortByRqs.forEach(sortByRq -> {

                String fieldName = sortByRq.getFieldName();
                if (fieldName.contains("estatus")) {

                    result[0] = true;
                    sortByRq.setFieldName(fieldName.replaceAll("\\bestatus\\b", "eStatusId"));
                } else if (entityClass.equals(Contract.class)) {

                    ArrayList<String> fields = new ArrayList<>();
                    fields.add("buyerId");
                    fields.add("sellerId");
                    fields.add("agentBuyerId");
                    fields.add("agentSellerId");
                    if (fields.contains(fieldName)) {

                        result[0] = true;
                        sortByRq.setFieldName("contractContacts.contactId");
                    }
                }

                String newFieldName = refineFieldName(sortByRq.getFieldName(), entityClass);
                if (!newFieldName.equals(sortByRq.getFieldName())) result[0] = true;

                sortBys.add((sortByRq.getDescendingSafe() ? "-" : "") + newFieldName);
            });

            searchRq.setSortBy(sortBys);
        }

        return result[0];
    }

    private Boolean checkCriteria(SearchDTO.CriteriaRq criteriaRq, Class<?> entityClass) {

        if (criteriaRq == null) return false;

        boolean result = false;
        String fieldName = criteriaRq.getFieldName();
        if (!StringUtils.isEmpty(fieldName)) {

            if (fieldName.contains("estatus")) {

                result = true;
                fieldName = refineEStatusField(fieldName, criteriaRq);
            }

            if (entityClass.equals(Contract.class)) {

                if (makeContractContactsCriteria(criteriaRq, fieldName))
                    return true;
            }

            Field field = getFieldByNames(fieldName, entityClass);
            String newFieldName = refineFieldName(fieldName, entityClass);
            if (!newFieldName.equals(fieldName)) {

                result = true;
                criteriaRq.setFieldName(newFieldName);
            }
            if (field.getType().equals(Date.class)) {

                final EOperator operator = criteriaRq.getOperator();
                if (operator == EOperator.lessOrEqual || operator == EOperator.greaterOrEqual)
                    result = refineDateField(newFieldName, criteriaRq, result);
                else {

                    if (criteriaRq.getCriteria() == null) return result;
                    for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                        result |= checkCriteria(subCriterion, entityClass);
                }
            } else if (field.getType().equals(BigDecimal.class)) {

                result = true;
                List<Object> values = criteriaRq.getValue();
                criteriaRq.setValue(values.stream().map(Object::toString).collect(Collectors.toList()));
            } /* else if (field.getType().equals(String.class)) {

                result = true;
                List<Object> values = criteriaRq.getValue();
                criteriaRq.setValue(values.stream().map(q -> q.toString().
                        replace("\u06A9", "\u0643").
                        replace("\u06CC", "\u0649")*//*.
                        replace("/\u06CC/g", "\u064A")*//*).collect(Collectors.toList()));
            } */ else {

                if (criteriaRq.getCriteria() == null) return result;
                for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                    result |= checkCriteria(subCriterion, entityClass);
            }
        } else {

            if (criteriaRq.getCriteria() == null) return result;
            for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                result |= checkCriteria(subCriterion, entityClass);
        }

        return result;
    }
}
