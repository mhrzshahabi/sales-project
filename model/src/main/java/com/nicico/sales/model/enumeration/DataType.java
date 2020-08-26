package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DataType {

    PersianDate(1),
    GeorgianDate(2),
    Boolean(3),
    BigDecimal(4),
    Integer(6),
    Long(7),
    String(8),
    Reference(9),
    ListOfReference(10);

    private final Integer id;
}
