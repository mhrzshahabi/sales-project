package com.nicico.sales.aop;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.utility.AuthorizationUtil;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.lang.reflect.ParameterizedType;

@Aspect
@Order(1)
@Component
@RequiredArgsConstructor
public class AuthorizationAspect {

    private final AuthorizationUtil authorizationUtil;

    @Before(value = "" +
            "execution(* com.nicico.sales.service.*.*(..)) && " +
            "@annotation(com.nicico.sales.annotation.Action) && " +
            "!@annotation(org.springframework.security.access.prepost.PreAuthorize)")
    public void authorize(JoinPoint joinPoint) {

//        Object target = joinPoint.getTarget();
//        if (target == null)
//            return;
//
//        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
//        Action action = signature.getMethod().getDeclaredAnnotation(Action.class);
//
//        if (StringUtils.isEmpty(action.authority())) {
//
//            ParameterizedType superClass = (ParameterizedType) target.getClass().getGenericSuperclass();
//            Class<?> entityClass = (Class<?>) superClass.getActualTypeArguments()[0];
//            String entityName = entityClass.getSimpleName();
//            authorizationUtil.checkStandardPermission(entityName, action.value().name());
//        } else if (action.value() != ActionType.Unknown)
//            authorizationUtil.checkStandardPermission(action.authority());
    }
}
