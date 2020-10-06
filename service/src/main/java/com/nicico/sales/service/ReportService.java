package com.nicico.sales.service;

import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import lombok.RequiredArgsConstructor;
import org.reflections.Reflections;
import org.reflections.scanners.MethodAnnotationsScanner;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.bind.annotation.*;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ReportService {

    private final ResourceBundleMessageSource messageSource;
    private final static List<Class> MAPPING_ANNOTATIONS = new ArrayList<>(Arrays.asList(RequestMapping.class, GetMapping.class, PutMapping.class, PostMapping.class, DeleteMapping.class, PatchMapping.class));

    @Transactional
    public List<ReportDTO.RestData> getAllRest() {

        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage("com.nicico.sales.controller"))
                .setScanners(new MethodAnnotationsScanner()));
        Set<Method> methods = reflections.getMethodsAnnotatedWith(Report.class);

        List<ReportDTO.RestData> restDataList = new ArrayList<>();
        methods.forEach(method -> {

            Class<?>[] parameterTypes = method.getParameterTypes();
            if (parameterTypes.length != 1 || !parameterTypes[0].equals(MultiValueMap.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            if (!method.getReturnType().equals(ResponseEntity.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            ReportDTO.RestData restData = new ReportDTO.RestData();

            Report reportAnnotation = method.getAnnotation(Report.class);
            Class<?> returnType = reportAnnotation.returnType();
            List<ReportDTO.FieldData> fields = new ArrayList<>();
            getFields(returnType, fields);

            Annotation methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
            Map<String, String> methodData = getMethodName(methodMappingAnnotation);

            String methodUrl = getMethodUrl(method) + methodData.values().iterator().next();

            String nameKey = reportAnnotation.nameKey();
            restData.setNameEN(messageSource.getMessage(nameKey, null, Locale.ENGLISH));
            restData.setNameFA(messageSource.getMessage(nameKey, null, Locale.forLanguageTag("fa")));
            restData.setUrl(methodUrl);
            restData.setMethod(methodData.keySet().iterator().next());
            restData.setFields(fields);

            restDataList.add(restData);
        });

        return restDataList;
    }

    private List<ReportDTO.FieldData> getFields(Class<?> returnType, List<ReportDTO.FieldData> fields) {
        ReflectionUtils.doWithFields(returnType, field -> {
            ReportDTO.FieldData fieldData = new ReportDTO.FieldData();
            fieldData.setName("");
            fieldData.setTitleEN("");
            fieldData.setTitleFA("");
            fieldData.setCanFilter(true);
            fieldData.setHidden(true);
            fieldData.setType("");
            fields.add(fieldData);
        }, field -> !field.isAnnotationPresent(IgnoreReportField.class));
        return fields;
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

    private String getMethodUrl(Method method) {

        String methodUrl = "";
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
}
