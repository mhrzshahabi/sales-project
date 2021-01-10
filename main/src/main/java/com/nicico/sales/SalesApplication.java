package com.nicico.sales;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.dto.report.ReportMethodDTO;
import org.reflections.Reflections;
import org.reflections.scanners.*;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.io.FileWriter;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.*;
import java.util.stream.Collectors;

@SpringBootApplication(scanBasePackages = {"com.nicico"})
@EnableJpaAuditing(modifyOnCreate = false, auditorAwareRef = "auditorProvider")
@EntityScan(basePackages = {"com.nicico.sales.model"})
@EnableJpaRepositories("com.nicico.sales.repository")

public class SalesApplication implements CommandLineRunner {

    @Autowired
    private ObjectMapper objectMapper;

    @Value("${nicico.report.package.controller.name}")
    private String restControllerPackage;

    private final static List<Class> MAPPING_ANNOTATIONS = new ArrayList<>(Arrays.asList(RequestMapping.class, GetMapping.class, PutMapping.class, PostMapping.class, DeleteMapping.class, PatchMapping.class));

    public static void main(String[] args) {
        SpringApplication.run(SalesApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {


        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage(restControllerPackage))
                .setScanners(new SubTypesScanner(), new FieldAnnotationsScanner(), new MethodAnnotationsScanner(), new TypeAnnotationsScanner(), new MethodParameterScanner()));

        saveReportUrls(reflections);
        saveSpecListUrls(reflections);
    }

    private void saveReportUrls(Reflections reflections) throws IOException {

        Set<ReportMethodDTO> reportMethods = new HashSet<>();
        Set<Method> methodsAnnotatedWithReport = reflections.getMethodsAnnotatedWith(Report.class);
        methodsAnnotatedWithReport.forEach(method -> {

            Class<?>[] parameterTypes = method.getParameterTypes();
            if (parameterTypes.length != 1 || !parameterTypes[0].equals(MultiValueMap.class))
                return;

            if (!method.getReturnType().equals(ResponseEntity.class))
                return;

            Optional<Annotation> methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst();
            Optional<Annotation> classMappingAnnotation = Arrays.stream(method.getDeclaringClass().getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst();
            if (!methodMappingAnnotation.isPresent() || !classMappingAnnotation.isPresent()) return;

            ReportMethodDTO reportMethod = new ReportMethodDTO();
            reportMethod.setName(method.getName());

            Map<String, String> methodData = getMethodName(methodMappingAnnotation.get());
            reportMethod.setApiMethod(methodData.keySet().iterator().next());
            reportMethod.setApiUrl(getMethodUrl(classMappingAnnotation.get()) + methodData.values().iterator().next());

            Report reportAnnotation = method.getAnnotation(Report.class);
            reportMethod.setAnnotationNameKey(reportAnnotation.nameKey());
            reportMethod.setAnnotationReturnType(reportAnnotation.returnType().getName());
            reportMethod.setAnnotationReturnTypeIsList(reportAnnotation.returnTypeIsList());

            reportMethods.add(reportMethod);
        });

        String content = objectMapper.writeValueAsString(reportMethods);
        writeFile("reportMethods.txt", content);
    }

    private void saveSpecListUrls(Reflections reflections) throws IOException {

        final Set<Method> restControllers = reflections.getMethodsMatchParams(MultiValueMap.class);

        List<String> restUrls = restControllers.stream().map(q -> q.getDeclaringClass().getAnnotation(RequestMapping.class).value()[0] + q.getAnnotation(GetMapping.class).value()[0]).collect(Collectors.toList());
        String content = objectMapper.writeValueAsString(restUrls);
        writeFile("restUrls.txt", content);
    }

    private String getMethodUrl(Annotation classMappingAnnotation) {

        String methodUrl;
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

    private void writeFile(String fileName, String content) throws IOException {

        FileWriter writer = new FileWriter(fileName);
        writer.write(content);
        writer.close();
    }
}