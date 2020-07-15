package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CategoryUnit {

    Finance(1),
    Time(2),
    Weight(3),
    Combination(4),
    Percent(5),
    Class(6);

    private final Integer id;
}
