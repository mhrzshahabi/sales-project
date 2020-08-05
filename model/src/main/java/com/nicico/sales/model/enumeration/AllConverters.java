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

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class InspectionRateValueTypeConverter implements AttributeConverter<InspectionRateValueType, Integer> {

        @Override
        public Integer convertToDatabaseColumn(InspectionRateValueType literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public InspectionRateValueType convertToEntityAttribute(Integer integer) {

            for (InspectionRateValueType literal : InspectionRateValueType.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class WeighingTypeConverter implements AttributeConverter<WeighingType, Integer> {

        @Override
        public Integer convertToDatabaseColumn(WeighingType literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public WeighingType convertToEntityAttribute(Integer integer) {

            for (WeighingType literal : WeighingType.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class DeductionTypeConverter implements AttributeConverter<DeductionType, Integer> {

        @Override
        public Integer convertToDatabaseColumn(DeductionType literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public DeductionType convertToEntityAttribute(Integer integer) {

            for (DeductionType literal : DeductionType.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class PriceBaseReferenceConverter implements AttributeConverter<PriceBaseReference, Integer> {

        @Override
        public Integer convertToDatabaseColumn(PriceBaseReference literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public PriceBaseReference convertToEntityAttribute(Integer integer) {

            for (PriceBaseReference literal : PriceBaseReference.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class RateReferenceConverter implements AttributeConverter<RateReference, Integer> {

        @Override
        public Integer convertToDatabaseColumn(RateReference literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public RateReference convertToEntityAttribute(Integer integer) {

            for (RateReference literal : RateReference.values())
                if (literal.getId().equals(integer))
                    return literal;

            return null;
        }
    }

    // *****************************************************************************************************************

    @Converter(autoApply = true)
    public static class CommercialRoleConverter implements AttributeConverter<CommercialRole, Integer> {

        @Override
        public Integer convertToDatabaseColumn(CommercialRole literal) {

            if (literal == null)
                return null;

            return literal.getId();
        }

        @Override
        public CommercialRole convertToEntityAttribute(Integer integer) {
            return Arrays.stream(CommercialRole.values())
                    .filter(literal -> literal.getId().equals(integer)).findFirst().orElse(null);
        }
    }
}
