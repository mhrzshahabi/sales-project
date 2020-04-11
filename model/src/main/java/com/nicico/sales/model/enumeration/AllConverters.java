package com.nicico.sales.model.enumeration;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.*;

public abstract class AllConverters {

    @Converter(autoApply = true)
    public static class EStatusConverter implements AttributeConverter<EStatus, Integer> {

        @Override
        public Integer convertToDatabaseColumn(EStatus literal) {

            return literal != null ? literal.getId() : null;
        }

        @Override
        public EStatus convertToEntityAttribute(Integer integer) {

            for (EStatus literal : EStatus.values())
                if (literal.getId().equals(integer)) return literal;

            return null;
        }
    }

    @Converter(autoApply = true)
    public static class EStatusListConverter implements AttributeConverter<List<EStatus>, Integer> {

        @Override
        public Integer convertToDatabaseColumn(List<EStatus> literals) {

            return EStatus.getStatusValue(literals);
        }

        @Override
        public List<EStatus> convertToEntityAttribute(Integer integer) {

            return EStatus.getStatusFlags(integer);
        }
    }
}
