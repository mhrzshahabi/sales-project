package com.nicico.sales.config;

import com.nicico.sales.annotation.i18n;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import org.modelmapper.Converter;
import org.modelmapper.spi.MappingContext;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Component
public class i18nConverter<S, D> implements Converter<S, D> {

    @Override
    public D convert(MappingContext<S, D> mappingContext) {

        try {
            Locale locale = LocaleContextHolder.getLocale();
            List<Field> destinationFields = new ArrayList<>();
            String propertyPostfix = locale.getLanguage().equals(Locale.ENGLISH.getLanguage()) ? "EN" : "FA";
            D destination = mappingContext.getDestinationType().newInstance();
            ReflectionUtils.doWithFields(mappingContext.getDestinationType(), destinationFields::add);
            for (Field destinationField : destinationFields) {

                destinationField.setAccessible(true);
                if (destinationField.getDeclaredAnnotation(i18n.class) != null) {

                    Field sourceField = ReflectionUtils.findField(mappingContext.getSourceType(), destinationField.getName() + propertyPostfix);
                    if (sourceField == null)
                        continue;
                    sourceField.setAccessible(true);
                    destinationField.set(destination, sourceField.get(mappingContext.getSource()));
                } else {

                    Field sourceField = ReflectionUtils.findField(mappingContext.getSourceType(), destinationField.getName());
                    if (sourceField == null)
                        continue;
                    sourceField.setAccessible(true);
                    destinationField.set(destination, sourceField.get(mappingContext.getSource()));
                }
            }

            return destination;
        } catch (InstantiationException | IllegalAccessException e) {

            throw new SalesException2(ErrorType.BadRequest, null, "خطا در نگاشت زبان داده ها");
        }
    }
}