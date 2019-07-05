package com.nicico.sales.model.enumeration;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

public abstract class AllConverters {

	// --------------- NICICO Enum Converters

	@Converter(autoApply = true)
	public static class EStatusConverter implements AttributeConverter<EStatus, Integer> {
		@Override
		public Integer convertToDatabaseColumn(EStatus literal) {
			return literal != null ? literal.getId() : null;
		}

		@Override
		public EStatus convertToEntityAttribute(Integer integer) {
			for (EStatus literal : EStatus.values()) {
				if (literal.getId().equals(integer)) {
					return literal;
				}
			}
			return null;
		}
	}
}
