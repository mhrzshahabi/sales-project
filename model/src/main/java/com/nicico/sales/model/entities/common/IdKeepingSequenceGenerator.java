package com.nicico.sales.model.entities.common;

import lombok.extern.slf4j.Slf4j;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.enhanced.SequenceStyleGenerator;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

@Slf4j
public class IdKeepingSequenceGenerator extends SequenceStyleGenerator {
    @Override
    public Serializable generate(SharedSessionContractImplementor session, Object object) throws HibernateException {
        Class objectClass = object.getClass();
        try {
            Method getId = objectClass.getMethod("getId");
            Long id = (Long) getId.invoke(object);
            if (id != null && id > 0) {
                return id;
            }
        } catch (NoSuchMethodException e) {
            log.warn(e.getMessage());
        } catch (IllegalAccessException e) {
            log.warn(e.getMessage());
        } catch (InvocationTargetException e) {
            log.warn(e.getMessage());
        }
        return super.generate(session, object);


    }
}