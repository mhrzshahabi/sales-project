package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DataType {

    Date,
    Boolean,
    Float,
    Double,
    Integer,
    Long,
    String;
}