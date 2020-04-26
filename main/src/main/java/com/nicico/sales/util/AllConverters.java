package com.nicico.sales.util;

import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.EStatus;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.EnumSet;

public abstract class AllConverters {

    @Converter(autoApply = true)
    public class EStatusConverter implements AttributeConverter<EStatus, Integer> {

        @Override
        public Integer convertToDatabaseColumn(EStatus literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public EStatus convertToEntityAttribute(Integer integer) {

            for (EStatus literal : EStatus.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    @Converter(autoApply = true)
    public class EStatusSetConverter implements AttributeConverter<EnumSet<EStatus>, Integer> {

        @Override
        public Integer convertToDatabaseColumn(EnumSet<EStatus> literals) {

            if (literals == null || literals.isEmpty())
                return null;

            int sum = 0;
            for (EStatus item : literals) {

                sum += item.getId();
            }

            return sum;
        }

        @Override
        public EnumSet<EStatus> convertToEntityAttribute(Integer integer) {

            if (EStatus.values().length == 0)
                return null;

            EnumSet<EStatus> result = EnumSet.noneOf(EStatus.class);
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
    public class DataTypeConverter implements AttributeConverter<DataType, Integer> {

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

    @Converter(autoApply = true)
    public class DataTypeSetConverter implements AttributeConverter<EnumSet<DataType>, Integer> {

        @Override
        public Integer convertToDatabaseColumn(EnumSet<DataType> literals) {

            if (literals == null || literals.isEmpty())
                return null;

            int sum = 0;
            for (DataType item : literals) {

                sum += item.getId();
            }

            return sum;
        }

        @Override
        public EnumSet<DataType> convertToEntityAttribute(Integer integer) {

            if (DataType.values().length == 0)
                return null;

            EnumSet<DataType> result = EnumSet.noneOf(DataType.class);
            Arrays.sort(DataType.values(), Collections.reverseOrder(Comparator.comparingInt(DataType::getId)));
            for (DataType literal : DataType.values()) {

                int id = literal.getId();
                if (id > integer) continue;

                result.add(literal);
                integer -= id;
            }

            return result;
        }
    }
}
