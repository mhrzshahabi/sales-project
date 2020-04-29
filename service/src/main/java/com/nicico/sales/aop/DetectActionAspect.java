package com.nicico.sales.aop;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.service.GenericService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;

@Aspect
@Order(2)
@Component
public class DetectActionAspect {

    @Before(value = "" +
            "@annotation(com.nicico.sales.annotation.Action) && " +
            "execution(* com.nicico.sales.service.GenericService+.*(..))")
    public void setActionType(JoinPoint joinPoint) throws IllegalAccessException, NoSuchFieldException {

        Object target = joinPoint.getTarget();
        if (target == null)
            return;

        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Action action = signature.getMethod().getDeclaredAnnotation(Action.class);
        Field actionTypeField = GenericService.class.getDeclaredField("actionType");
        actionTypeField.setAccessible(true);
        actionTypeField.set(target, action.value());
    }
}