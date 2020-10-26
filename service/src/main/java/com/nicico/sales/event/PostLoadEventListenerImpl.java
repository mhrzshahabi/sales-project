package com.nicico.sales.event;

import com.nicico.sales.model.annotation.I18n;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.event.spi.PostLoadEvent;
import org.hibernate.event.spi.PostLoadEventListener;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Slf4j
@Component
public class PostLoadEventListenerImpl implements PostLoadEventListener {

    @Override
    public void onPostLoad(PostLoadEvent postLoadEvent) {

        Class<?> entityClass = postLoadEvent.getEntity().getClass();
        I18n classAnnotation = entityClass.getDeclaredAnnotation(I18n.class);
        if (classAnnotation == null) return;

        List<Field> fields = new ArrayList<>();
        ReflectionUtils.doWithFields(entityClass, fields::add);

        Locale locale = LocaleContextHolder.getLocale();
        String propertyPostfix = locale.getLanguage().equals(Locale.ENGLISH.getLanguage()) ? "EN" : "FA";

        for (Field field : fields) {

            Annotation fieldAnnotation = field.getAnnotation(I18n.class);
            if (fieldAnnotation == null)
                continue;

            Field i18nField = ReflectionUtils.findField(entityClass, field.getName() + propertyPostfix);
            if (i18nField == null)
                continue;

            field.setAccessible(true);
            i18nField.setAccessible(true);
            try {

                field.set(postLoadEvent.getEntity(), i18nField.get(postLoadEvent.getEntity()));
            } catch (IllegalAccessException e) {

                throw new SalesException2(ErrorType.BadRequest, null, "خطا در نگاشت زبان داده ها");
            }
        }
    }
}