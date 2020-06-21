package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DeductionType {

    Unit(1),
    Percent(2),
    Discount(3);

    private final Integer id;
}
