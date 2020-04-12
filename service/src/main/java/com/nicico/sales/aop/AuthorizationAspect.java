package com.nicico.sales.aop;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.utility.AuthorizationUtil;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

@Aspect
@Component
@RequiredArgsConstructor
public class AuthorizationAspect {

    private final AuthorizationUtil authorizationUtil;

    @Before(value = "execution(* com.nicico.sales.service.GenericService.*(..)) && @annotation(com.nicico.sales.annotation.Action)")
    public void authorize(JoinPoint joinPoint) {

        Object target = joinPoint.getTarget();
        if (target == null)
            return;

        String entityName = target.getClass().getSimpleName();
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Action action = signature.getMethod().getDeclaredAnnotation(Action.class);
        authorizationUtil.checkStandardPermission(entityName, action.value().name());
    }
}