package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DataType {

    PersianDate(1),
    GeorgianDate(2),
    Boolean(3),
    Float(4),
    Double(5),
    Integer(6),
    Long(7),
    String(8),
    Column(9);

    private final Integer id;
}
