package com.nicico.sales.model.enumeration;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.*;

public abstract class AllConverters {

    @Converter(autoApply = true)
    public static class EStatusSetConverter implements AttributeConverter<List<EStatus>, Integer> {

        @Override
        public Integer convertToDatabaseColumn(List<EStatus> literals) {

            if (literals == null || literals.isEmpty())
                return null;

            int sum = 0;
            for (EStatus item : literals) {

                sum += item.getId();
            }

            return sum;
        }

        @Override
        public List<EStatus> convertToEntityAttribute(Integer integer) {

            if (EStatus.values().length == 0)
                return null;

            List<EStatus> result = new ArrayList<>();
            Arrays.sort(EStatus.values(), Collections.reverseOrder(Comparator.comparingInt(EStatus::getId)));
            for (EStatus literal : EStatus.values()) {

                int id = literal.getId();
                if (id > integer) continue;

                result.add(literal);
                integer -= id;
            }

            return result;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class DataTypeConverter implements AttributeConverter<DataType, Integer> {

        @Override
        public Integer convertToDatabaseColumn(DataType literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public DataType convertToEntityAttribute(Integer integer) {

            for (DataType literal : DataType.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }
}
