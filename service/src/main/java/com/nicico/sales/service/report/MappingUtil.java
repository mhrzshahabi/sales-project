package com.nicico.sales.service.report;

import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.Conditions;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;
import org.modelmapper.TypeToken;
import org.modelmapper.convention.MatchingStrategies;
import org.modelmapper.spi.MappingContext;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class MappingUtil {

    public ModelMapper getModelMapper(Class destinationType) {

        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);

        TypeMap<LinkedHashMap<String, Object>, Object> reportDataMapTypeMap = modelMapper.createTypeMap(new TypeToken<LinkedHashMap<String, Object>>() {
        }.getRawType(), destinationType);
        reportDataMapTypeMap.setConverter(new ReportDataMapConverter(modelMapper));

        TypeMap<Object, Object> reportDataObjectTypeMap = modelMapper.createTypeMap(Object.class, Object.class, "ReportDataObjectTypeMap");
        reportDataObjectTypeMap.setConverter(new ReportDataObjectConverter(modelMapper));

        modelMapper.getConfiguration().setPropertyCondition(Conditions.isNotNull());

        return modelMapper;
    }

    private Object cast(String fieldName, Object value, Class<?> castTo) {

        if (String.class.equals(castTo))
            return String.valueOf(value);
        if (byte.class.equals(castTo) || Byte.class.equals(castTo))
            return Byte.valueOf(String.valueOf(value));
        if (boolean.class.equals(castTo) || Boolean.class.equals(castTo))
            return Boolean.valueOf(String.valueOf(value));
        if (long.class.equals(castTo) || Long.class.equals(castTo))
            return Long.valueOf(String.valueOf(value));
        if (short.class.equals(castTo) || Short.class.equals(castTo))
            return Short.valueOf(String.valueOf(value));
        if (int.class.equals(castTo) || Integer.class.equals(castTo))
            return Integer.valueOf(String.valueOf(value));
        if (float.class.equals(castTo) || Float.class.equals(castTo))
            return Float.valueOf(String.valueOf(value));
        if (double.class.equals(castTo) || Double.class.equals(castTo))
            return Double.valueOf(String.valueOf(value));
        if (BigDecimal.class.equals(castTo))
            return new BigDecimal(String.valueOf(value));
        if (Date.class.equals(castTo))
            return new Date(Long.parseLong(String.valueOf(value)));

        throw new SalesException2(ErrorType.BadRequest, fieldName, "خطا در تبدیل داده های گزارش");
    }

    private void setDestinationFieldValue(ModelMapper modelMapper, Object destination, Field field, Object value) throws IllegalAccessException {

        if (value == null)
            return;

        field.setAccessible(true);
        Class<?> fieldType = field.getType();
        ReportModel reportModelAnnotation = field.getAnnotation(ReportModel.class);
        if (reportModelAnnotation != null) {

            if (!reportModelAnnotation.jumpTo())
                return;

            if (fieldType.equals(Set.class)) {

                HashSet<Object> objects = new HashSet<>();
                for (Object obj : (Iterable) value)
                    objects.add(modelMapper.map(obj, reportModelAnnotation.type(), "ReportDataObjectTypeMap"));

                field.set(destination, objects);
                return;
            }

            if (fieldType.equals(List.class)) {

                List<Object> objects = new ArrayList<>();
                for (Object obj : (Iterable) value)
                    modelMapper.map(obj, reportModelAnnotation.type(), "ReportDataObjectTypeMap");

                field.set(destination, objects);
                return;
            }

            field.set(destination, modelMapper.map(value, reportModelAnnotation.type(), "ReportDataObjectTypeMap"));
        } else field.set(destination, cast(field.getName(), value, fieldType));
    }

    private class ReportDataObjectConverter implements org.modelmapper.Converter<Object, Object> {

        private ModelMapper modelMapper;

        ReportDataObjectConverter(ModelMapper modelMapper) {

            this.modelMapper = modelMapper;
        }

        @Override
        public Object convert(MappingContext<Object, Object> context) {

            Object source = context.getSource();
            if (source == null) return null;

            Object destination = null;
            try {
                destination = context.getDestinationType().newInstance();
            } catch (InstantiationException | IllegalAccessException e) {
                log.error(e.getMessage());
            }
            if (destination == null) return null;

            Object finalDestination = destination;
            ReflectionUtils.doWithFields(context.getDestinationType(),
                    field -> {
                        field.setAccessible(true);
                        setDestinationFieldValue(this.modelMapper, finalDestination, field, field.get(source));
                    },
                    field -> !field.isAnnotationPresent(IgnoreReportField.class));

            return finalDestination;
        }
    }

    private class ReportDataMapConverter implements org.modelmapper.Converter<LinkedHashMap<String, Object>, Object> {

        private ModelMapper modelMapper;

        ReportDataMapConverter(ModelMapper modelMapper) {

            this.modelMapper = modelMapper;
        }

        @Override
        public Object convert(MappingContext<LinkedHashMap<String, Object>, Object> context) {

            Map<String, Object> source = context.getSource();
            if (source == null) return null;

            Object destination = null;
            try {
                destination = context.getDestinationType().newInstance();
            } catch (InstantiationException | IllegalAccessException e) {
                log.error(e.getMessage());
            }
            if (destination == null) return null;

            Object finalDestination = destination;
            ReflectionUtils.doWithFields(context.getDestinationType(),
                    field -> setDestinationFieldValue(this.modelMapper, finalDestination, field, context.getSource().get(field.getName())),
                    field -> !field.isAnnotationPresent(IgnoreReportField.class));

            return finalDestination;
        }
    }

}
