//package com.nicico.sales.util;
//
//import lombok.SneakyThrows;
//import org.springframework.stereotype.Component;
//
//import javax.persistence.AttributeConverter;
//import javax.persistence.Converter;
//import java.lang.reflect.Method;
//import java.lang.reflect.ParameterizedType;
//
//@Component
//@Converter(autoApply = true)
//public class EnumConverter<E extends Enum<E>> implements AttributeConverter<E, Integer> {
//
//    private Class<E> eType;
//    private Method getIdMethod;
//
//    {
//        ParameterizedType superInterface = (ParameterizedType) getClass().getGenericInterfaces()[0];
//        //noinspection unchecked
//        eType = (Class<E>) superInterface.getActualTypeArguments()[0].getClass();
//
//        try {
//            getIdMethod = eType.getDeclaredMethod("getId");
//        } catch (NoSuchMethodException e) {
//            // ignore
//        }
//    }
//
//    @Override
//    @SneakyThrows
//    public Integer convertToDatabaseColumn(E literal) {
//
//        if (literal == null)
//            return null;
//
//        return getIdMethod == null ? literal.ordinal() : (Integer) getIdMethod.invoke(literal);
//    }
//
//    @Override
//    @SneakyThrows
//    public E convertToEntityAttribute(Integer integer) {
//
//        for (E literal : eType.getEnumConstants())
//            if (convertToDatabaseColumn(literal).equals(integer))
//                return literal;
//
//        return null;
//    }
//}
