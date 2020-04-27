package com.nicico.sales.aop;

import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotEditableException;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.service.GenericService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.List;

@Aspect
@Order(3)
@Component
public class ValidationAspect {

    @Around("execution(* com.nicico.sales.service.GenericService+.validation(com.nicico.sales.model.entities.common.BaseEntity, *)) && args(entity)")
    public void setActionType(JoinPoint joinPoint, BaseEntity entity) throws NoSuchFieldException, IllegalAccessException {

        if (entity == null || entity.getEditable())
            return;
        Object target = joinPoint.getTarget();
        if (!(target instanceof GenericService))
            return;

        Field actionTypeField = GenericService.class.getDeclaredField("actionType");
        actionTypeField.setAccessible(true);
        ActionType actionType = (ActionType) actionTypeField.get(target);
        if (actionType != ActionType.Update)
            return;

        throw new NotEditableException();
    }

    @Around("execution(* com.nicico.sales.service.GenericService+.validationAll(java.util.List<com.nicico.sales.model.entities.common.BaseEntity>, *)) && args(entities)")
    public void setActionType(ProceedingJoinPoint joinPoint, List<BaseEntity> entities) throws IllegalAccessException, NoSuchFieldException {

        Object target = joinPoint.getTarget();
        if (!(target instanceof GenericService))
            return;

        Field actionTypeField = GenericService.class.getDeclaredField("actionType");
        actionTypeField.setAccessible(true);
        ActionType actionType = (ActionType) actionTypeField.get(target);
        if (actionType != ActionType.UpdateAll)
            return;

        for (BaseEntity entity : entities) {

            if (entity == null || entity.getEditable())
                continue;

            throw new NotEditableException();
        }
    }
}
