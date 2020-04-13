package com.nicico.sales.aop;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.utility.AuthorizationUtil;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.ParameterizedType;

@Aspect
@Component
@RequiredArgsConstructor
public class AuthorizationAspect {

    private final AuthorizationUtil authorizationUtil;

    @Before(value = "" +
            "execution(* com.nicico.sales.service.*.*(*)) && " +
            "@annotation(com.nicico.sales.annotation.Action) && " +
            "!@annotation(org.springframework.security.access.prepost.PreAuthorize)")
    public void authorize(JoinPoint joinPoint) {

        Object target = joinPoint.getTarget();
        if (target == null)
            return;

        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Action action = signature.getMethod().getDeclaredAnnotation(Action.class);
        if (action == null || action.value() == ActionType.Unknown)
            return;

        ParameterizedType superClass = (ParameterizedType) target.getClass().getGenericSuperclass();
        Class<?> entityClass = (Class<?>) superClass.getActualTypeArguments()[0];
        String entityName = entityClass.getSimpleName();
        authorizationUtil.checkStandardPermission(entityName, action.value().name());
    }
}