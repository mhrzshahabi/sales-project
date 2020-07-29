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
    Column(9),
    Reference(10),
    ListOfReference(11);

    private final Integer id;
}
