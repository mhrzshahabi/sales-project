package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum InspectionRateValueType {

    ManPerDay(1),
    PerTon(2);

    private final Integer id;
}
