package com.nicico.sales.service.report;

import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.report.IReportService;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.reflections.Reflections;
import org.reflections.scanners.MethodAnnotationsScanner;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReportService extends GenericService<com.nicico.sales.model.entities.report.Report, Long, ReportDTO.Create, ReportDTO.Info, ReportDTO.Update, ReportDTO.Delete> implements IReportService {

    @Value("${nicico.report.package.controller-name}")
    private String restControllerPackage;

    private final EntityManager entityManager;
    private final ResourceBundleMessageSource messageSource;

    private final static String VIEW_NAME_QUERY_TEXT = "" +
            "SELECT\n" +
            "   VIEW_NAME\n" +
            "FROM\n" +
            "   USER_VIEWS";
    private final static String[] VIEW_FIELDS_OBJECT_COLUMNS = {"className", "name", "hidden", "canFilter", "dataIsList", "type"};
    private final static String VIEW_FIELDS_QUERY_TEXT = "" +
            "SELECT\n" +
            "    TABLE_NAME              AS className,\n" +
            "    COLUMN_NAME             AS name,\n" +
            "    0                       AS hidden,\n" +
            "    1                       AS canFilter,\n" +
            "    1                       AS dataIsList,\n" +
            "    (CASE\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'INT'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'LONG'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'INTEGER'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'SMALLINT'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%NUMBER%' AND (DATA_SCALE IS NULL OR DATA_SCALE = 0)\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%FLOAT%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DOUBLE%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DECIMAL%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%NUMBER%' AND DATA_SCALE IS NOT NULL AND DATA_SCALE > 0\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DATE%'\n" +
            "        THEN 'date'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%TIMESTAMP%'\n" +
            "        THEN 'date'\n" +
            "        ELSE 'text'\n" +
            "    END)                    AS type\n" +
            "FROM\n" +
            "    user_tab_columns\n" +
            "WHERE\n" +
            "    table_name = ?";
    private final static List<Class> MAPPING_ANNOTATIONS = new ArrayList<>(Arrays.asList(RequestMapping.class, GetMapping.class, PutMapping.class, PostMapping.class, DeleteMapping.class, PatchMapping.class));

    @Override
    @Transactional(readOnly = true)
    public List<ReportDTO.SourceData> getSourceData(ReportSource reportSource) {

        return reportSource == ReportSource.Rest ? getRestData() : getViewData();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ReportDTO.FieldData> getSourceFields(ReportSource reportSource, String source) {

        return reportSource == ReportSource.Rest ? getRestFields(source) : getViewFields(source);
    }

    private List<ReportDTO.SourceData> getViewData() {

        Query viewNameQuery = entityManager.createNativeQuery(VIEW_NAME_QUERY_TEXT);
        List<String> viewNames = modelMapper.map(viewNameQuery.getResultList(), new TypeToken<List<String>>() {
        }.getType());

        List<ReportDTO.SourceData> viewDataList = new ArrayList<>();
        viewNames.forEach(viewName -> {

            ReportDTO.SourceData viewData = new ReportDTO.SourceData();

            viewData.setNameEN(viewName);
            viewData.setNameFA(viewName);
            viewData.setSource(viewName);
            viewData.setDataIsList(true);

            viewDataList.add(viewData);
        });

        return viewDataList;
    }

    private List<ReportDTO.SourceData> getRestData() {

        Set<Method> methods = getSpecListMethods();

        List<ReportDTO.SourceData> restDataList = new ArrayList<>();
        methods.forEach(method -> {

            Class<?>[] parameterTypes = method.getParameterTypes();
            if (parameterTypes.length != 1 || !parameterTypes[0].equals(MultiValueMap.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            if (!method.getReturnType().equals(ResponseEntity.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            ReportDTO.SourceData restData = new ReportDTO.SourceData();

            Annotation methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
            Map<String, String> methodData = getMethodName(methodMappingAnnotation);

            String methodUrl = getMethodUrl(method) + methodData.values().iterator().next();

            Report reportAnnotation = method.getAnnotation(Report.class);
            String nameKey = reportAnnotation.nameKey();
            restData.setNameEN(messageSource.getMessage(nameKey, null, Locale.ENGLISH));
            restData.setNameFA(messageSource.getMessage(nameKey, null, Locale.forLanguageTag("fa")));
            restData.setDataIsList(reportAnnotation.returnTypeIsList());
            restData.setSource(methodUrl);
            restData.setRestMethod(methodData.keySet().iterator().next());

            restDataList.add(restData);
        });

        return restDataList;
    }

    private List<ReportDTO.FieldData> getViewFields(String source) {

        Query viewFieldsQuery = entityManager.createNativeQuery(VIEW_FIELDS_QUERY_TEXT);
        viewFieldsQuery.setParameter(1, source);
        List<Map<String, Object>> viewFieldMaps = new ArrayList<>();
        viewFieldsQuery.getResultList().forEach(result -> {

            Object[] resultArray = ((Object[]) result);
            Map<String, Object> viewFieldMap = new HashMap<>();
            for (int i = 0; i < resultArray.length; i++)
                viewFieldMap.put(VIEW_FIELDS_OBJECT_COLUMNS[i], resultArray[i]);

            viewFieldMaps.add(viewFieldMap);
        });

        return modelMapper.map(viewFieldMaps, new TypeToken<List<ReportDTO.FieldData>>() {
        }.getType());
    }

    private List<ReportDTO.FieldData> getRestFields(String source) {

        Set<Method> methods = getSpecListMethods();
        Method sourceMethod = methods.stream().filter(method -> {

            Annotation methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
            Map<String, String> methodData = getMethodName(methodMappingAnnotation);

            String methodUrl = getMethodUrl(method) + methodData.values().iterator().next();

            return methodUrl.equals(source);
        }).findFirst().orElseThrow(() -> new NotFoundException("متد مورد نظر یافت نشد."));

        Report reportAnnotation = sourceMethod.getAnnotation(Report.class);
        Class<?> returnType = reportAnnotation.returnType();
        List<ReportDTO.FieldData> fields = new ArrayList<>();
        getFields("", returnType, fields);

        return fields;
    }

    private Set<Method> getSpecListMethods() {

        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage(restControllerPackage))
                .setScanners(new MethodAnnotationsScanner()));

        return reflections.getMethodsAnnotatedWith(Report.class);
    }

    private String mapType(Class<?> type) {

        if (type.equals(Boolean.class)) return "boolean";
        else if (type.equals(Byte.class)) return "integer";
        else if (type.equals(Short.class)) return "integer";
        else if (type.equals(Integer.class)) return "integer";
        else if (type.equals(Long.class)) return "integer";
        else if (type.equals(Float.class)) return "float";
        else if (type.equals(Double.class)) return "float";
        else if (type.equals(BigDecimal.class)) return "float";
        else if (type.equals(Date.class)) return "date";
        else if (type.equals(Character.class) || type.equals(String.class) || type.isEnum()) return "text";
        else return null;
    }

    private String getMethodUrl(Method method) {

        String methodUrl;
        Annotation classMappingAnnotation = Arrays.stream(method.getDeclaringClass().getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
        if (GetMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((GetMapping) classMappingAnnotation).value()[0];
        else if (PutMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PutMapping) classMappingAnnotation).value()[0];
        else if (PostMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PostMapping) classMappingAnnotation).value()[0];
        else if (DeleteMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((DeleteMapping) classMappingAnnotation).value()[0];
        else if (PatchMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PatchMapping) classMappingAnnotation).value()[0];
        else
            methodUrl = ((RequestMapping) classMappingAnnotation).value()[0];

        return methodUrl;
    }

    private Map<String, String> getMethodName(Annotation methodMappingAnnotation) {

        Map<String, String> map = new HashMap<>();
        if (GetMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("GET", ((GetMapping) methodMappingAnnotation).value()[0]);
        else if (PutMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("PUT", ((PutMapping) methodMappingAnnotation).value()[0]);
        else if (PostMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("POST", ((PostMapping) methodMappingAnnotation).value()[0]);
        else if (DeleteMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("DELETE", ((DeleteMapping) methodMappingAnnotation).value()[0]);
        else if (PatchMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("PATCH", ((PatchMapping) methodMappingAnnotation).value()[0]);
        else
            map.put(((RequestMapping) methodMappingAnnotation).method()[0].name(), ((RequestMapping) methodMappingAnnotation).value()[0]);

        return map;
    }

    private void getFields(String baseName, Class<?> returnType, List<ReportDTO.FieldData> fields) {

        ReflectionUtils.doWithFields(returnType, field -> {

            ReportDTO.FieldData fieldData = new ReportDTO.FieldData();
            ReportField reportFieldAnnotation = field.getAnnotation(ReportField.class);

            if (!StringUtils.isEmpty(baseName)) {

                fieldData.setClassName(baseName);
                fieldData.setName(baseName + "." + field.getName());
            } else
                fieldData.setName(field.getName());

            if (reportFieldAnnotation != null) {

                fieldData.setHidden(reportFieldAnnotation.hidden());
                fieldData.setCanFilter(reportFieldAnnotation.canFilter());

                String titleMessageKey = reportFieldAnnotation.titleMessageKey();
                fieldData.setTitleEN(messageSource.getMessage(titleMessageKey, null, Locale.ENGLISH));
                fieldData.setTitleFA(messageSource.getMessage(titleMessageKey, null, Locale.forLanguageTag("fa")));
            } else {

                fieldData.setHidden(false);
                fieldData.setCanFilter(true);
            }

            fieldData.setType(mapType(field.getType()));

            ReportModel reportModelAnnotation = field.getAnnotation(ReportModel.class);
            if (reportModelAnnotation != null) fieldData.setDataIsList(reportModelAnnotation.typeIsList());
            else fieldData.setDataIsList(false);
            fields.add(fieldData);

            if (reportModelAnnotation != null && reportModelAnnotation.jumpTo())
                getFields(fieldData.getName(), reportModelAnnotation.type(), fields);
        }, field -> !field.isAnnotationPresent(IgnoreReportField.class));
    }
}
