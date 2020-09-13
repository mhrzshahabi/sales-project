package com.nicico.sales.aop;

import com.google.common.base.Enums;
import com.google.common.base.Optional;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.enumeration.AllConverters;
import com.nicico.sales.model.enumeration.EStatus;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.nicico.copper.common.domain.criteria.SearchUtil.createSearchRq;
import static com.nicico.copper.common.domain.criteria.SearchUtil.mapSearchRs;

@Aspect
@Order(3)
@Component
@RequiredArgsConstructor
public class CriteriaRefinerAspect {

    @Around(value = "execution(* com.nicico.sales.service.GenericService+.search(..)) && args(request)")
    public TotalResponse<? extends Object> refineDateCriteria(ProceedingJoinPoint proceedingJoinPoint, NICICOCriteria request) throws Throwable {

        Object target = proceedingJoinPoint.getTarget();
        if (target == null)
            return (TotalResponse<?>) proceedingJoinPoint.proceed();

        ParameterizedType superClass = (ParameterizedType) target.getClass().getGenericSuperclass();
        Class<?> entityClass = (Class<?>) superClass.getActualTypeArguments()[0];
        SearchDTO.SearchRq newRequest = createSearchRq(request);
        try {
            if (checkCriteria(newRequest.getCriteria(), entityClass)) {

                final Method searchMethod = target.getClass().getMethod("search", SearchDTO.SearchRq.class);
                return mapSearchRs(request, (SearchDTO.SearchRs<?>) searchMethod.invoke(target, newRequest));
            } else throw new Throwable();
        } catch (Throwable e) {
            return (TotalResponse<?>) proceedingJoinPoint.proceed();
        }
    }

    private Field getField(String fieldName, Class<?> entityClass) {

        try {

            return entityClass.getDeclaredField(fieldName);

        } catch (NoSuchFieldException e) {

            return getField(fieldName, entityClass.getSuperclass());
        }
    }

    private Field getFieldByNames(String fieldName, Class<?> entityClass) throws NoSuchFieldException {

        final String[] fieldNames = fieldName.split("\\.");
        Field field = getField(fieldNames[0], entityClass);
        for (int i = 1; i < fieldNames.length; i++)
            field = field.getType().getDeclaredField(fieldNames[i]);

        return field;
    }

    private String refineEStatusField(String fieldName, SearchDTO.CriteriaRq criteriaRq) {

        fieldName = fieldName.replace("estatus", "eStatusId");
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
                if (statusOptional.isPresent())
                    statuses.add(statusOptional.get());
            }
            criteriaRq.setValue(new AllConverters.EStatusSetConverter().convertToDatabaseColumn(statuses));
        }

        return fieldName;
    }

    private boolean refineDateField(String fieldName, SearchDTO.CriteriaRq criteriaRq, boolean result) {

        List<Date> newValues = new ArrayList<>();
        final List<Object> values = criteriaRq.getValue();
        for (Object value : values)
            if (value instanceof Date)
                newValues.add((Date) value);
            else if (value instanceof String) {

                result = true;

                String date = String.valueOf(value);
                if (date.length() <= 10) {

                    if (criteriaRq.getOperator() == EOperator.lessOrEqual)
                        date += " 23:59:59";
                    else
                        date += " 00:00:00";
                }

                newValues.add(new Date(date.replace('-', '/')));
            } else if (value instanceof Map)
                throw new SalesException2(ErrorType.BadRequest, fieldName, "Criteria options not supported yet.");
            else
                throw new SalesException2(ErrorType.BadRequest, fieldName, "Criteria for date field is incorrect.");

        criteriaRq.setValue(newValues);
        return result;
    }

    private Boolean checkCriteria(SearchDTO.CriteriaRq criteriaRq, Class<?> entityClass) throws NoSuchFieldException {

        if (criteriaRq == null)
            return false;

        boolean result = false;
        String fieldName = criteriaRq.getFieldName();
        if (!StringUtils.isEmpty(fieldName)) {

            if (fieldName.contains("estatus")) {

                result = true;
                fieldName = refineEStatusField(fieldName, criteriaRq);
            }

            Field field = getFieldByNames(fieldName, entityClass);
            if (field.getType().equals(Date.class)) {

                final EOperator operator = criteriaRq.getOperator();
                if (operator == EOperator.lessOrEqual || operator == EOperator.greaterOrEqual)
                    result = refineDateField(fieldName, criteriaRq, result);
                else {

                    if (criteriaRq.getCriteria() == null)
                        return result;
                    for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                        result |= checkCriteria(subCriterion, entityClass);
                }
            } else if (field.getType().equals(BigDecimal.class)) {

                criteriaRq.setValue(criteriaRq.getValue().toString());
            } else {

                if (criteriaRq.getCriteria() == null)
                    return result;
                for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                    result |= checkCriteria(subCriterion, entityClass);
            }
        } else {

            if (criteriaRq.getCriteria() == null)
                return result;
            for (SearchDTO.CriteriaRq subCriterion : criteriaRq.getCriteria())
                result |= checkCriteria(subCriterion, entityClass);
        }

        return result;
    }
}
