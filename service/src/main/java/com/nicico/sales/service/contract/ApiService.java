package com.nicico.sales.service.contract;

import lombok.RequiredArgsConstructor;
import org.reflections.Reflections;
import org.reflections.scanners.*;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class ApiService {

    public List<String> getRestApis() {

        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage("com.nicico.sales.controller"))
                .setScanners(new SubTypesScanner(), new FieldAnnotationsScanner(), new MethodAnnotationsScanner(), new TypeAnnotationsScanner(), new MethodParameterScanner()));

        final Set<Method> restControllers = reflections.getMethodsMatchParams(MultiValueMap.class);
        return restControllers.stream().map(q -> q.getDeclaringClass().getAnnotation(RequestMapping.class).value()[0] + q.getAnnotation(GetMapping.class).value()[0]).collect(Collectors.toList());
    }
}
