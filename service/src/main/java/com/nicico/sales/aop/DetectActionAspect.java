package com.nicico.sales.aop;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.service.GenericService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;

@Aspect
@Component
public class DetectActionAspect {

    @Before(value = "@annotation(com.nicico.sales.annotation.Action)")
    public void setActionType(JoinPoint joinPoint) throws IllegalAccessException, NoSuchFieldException {

        Object target = joinPoint.getTarget();
        if (target == null)
            return;

        Class<?> targetClass = target.getClass();
        if (GenericService.class.isAssignableFrom(targetClass)) {

            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Action action = signature.getMethod().getDeclaredAnnotation(Action.class);
            Field actionTypeField = GenericService.class.getDeclaredField("actionType");
            actionTypeField.setAccessible(true);
            actionTypeField.set(target, action.value());
        }
    }
}