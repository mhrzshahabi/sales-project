package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SymbolCurrency {

    $(1),
    CNH(2),
    €(3),
    £(4),
    ¢(5),
    ¥(6),
    RIAL(7);

    private final Integer id;
}
