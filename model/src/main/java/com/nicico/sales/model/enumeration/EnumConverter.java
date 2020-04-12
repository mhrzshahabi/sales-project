package com.nicico.sales.model.enumeration;

import lombok.SneakyThrows;
import org.springframework.stereotype.Component;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;

@Component
@Converter(autoApply = true)
public class EnumConverter<E extends Enum<E>> implements AttributeConverter<E, Integer> {

    private Class<E> eType;
    private Method getIdMethod;

    {
        ParameterizedType superClass = (ParameterizedType) getClass().getGenericSuperclass();
        //noinspection unchecked
        eType = (Class<E>) superClass.getActualTypeArguments()[0];

        try {
            getIdMethod = eType.getDeclaredMethod("getId");
        } catch (NoSuchMethodException e) {
            // ignore
        }
    }

    @Override
    @SneakyThrows
    public Integer convertToDatabaseColumn(E literal) {

        if (literal == null)
            return null;

        return getIdMethod == null ? literal.ordinal() : (Integer) getIdMethod.invoke(literal);
    }

    @Override
    @SneakyThrows
    public E convertToEntityAttribute(Integer integer) {

        for (E literal : eType.getEnumConstants())
            if (convertToDatabaseColumn(literal).equals(integer))
                return literal;

        return null;
    }
}