package com.nicico.sales.model.enumeration;

import lombok.SneakyThrows;
import org.springframework.stereotype.Component;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.EnumSet;

@Component
@Converter(autoApply = true)
public class EnumSetConverter<E extends Enum<E>> implements AttributeConverter<EnumSet<E>, Integer> {

    private Class<E> eType;
    private Method getIdMethod;

    {
        ParameterizedType superInterface = (ParameterizedType) getClass().getGenericInterfaces()[0];
        ParameterizedType firstTypeArgument = (ParameterizedType) superInterface.getActualTypeArguments()[0];
        //noinspection unchecked
        eType = (Class<E>) firstTypeArgument.getActualTypeArguments()[0].getClass();

        try {
            getIdMethod = eType.getDeclaredMethod("getId");
        } catch (NoSuchMethodException e) {
            // ignore
        }
    }

    @Override
    @SneakyThrows
    public Integer convertToDatabaseColumn(EnumSet<E> literals) {

        if (literals == null || literals.isEmpty())
            return null;

        int sum = 0;
        for (E item : literals) {

            int invoke = (int) getIdMethod.invoke(item);
            sum += invoke;
        }

        return sum;
    }

    @SneakyThrows
    @Override
    public EnumSet<E> convertToEntityAttribute(Integer integer) {

        //noinspection unchecked
        E[] values = (E[]) EnumSet.allOf(eType).toArray();
        if (values.length == 0)
            return null;

        EnumSet<E> result = EnumSet.noneOf(eType);
        Arrays.sort(values, Collections.reverseOrder(Comparator.comparingInt(item -> {
            try {
                return (int) getIdMethod.invoke(item);
            } catch (IllegalAccessException | InvocationTargetException e) {
                return 0;
            }
        })));
        for (E literal : values) {

            int id = (int) getIdMethod.invoke(literal);
            if (id > integer) continue;

            result.add(literal);
            integer -= id;
        }

        return result;
    }
}