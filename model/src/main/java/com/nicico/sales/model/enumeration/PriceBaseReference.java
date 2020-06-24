package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PriceBaseReference {

    LME(1),
    MetalsWeek(2);

    private final Integer id;
}
