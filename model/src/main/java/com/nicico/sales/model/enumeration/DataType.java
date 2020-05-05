package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DataType {

    Date(1),
    Boolean(2),
    Float(3),
    Double(4),
    Integer(5),
    Long(6),
    String(7),
    Column(8);

    private final Integer id;
}
