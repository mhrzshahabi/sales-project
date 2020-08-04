package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CurrencyType {
    AZAD(1),
    NIMAEE(2);

    private final Integer id;
}
