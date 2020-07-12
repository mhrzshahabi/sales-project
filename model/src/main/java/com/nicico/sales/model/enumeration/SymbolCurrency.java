package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SymbolCurrency {

    USD("$"),
    RIALS("ريال");

    private final String symCu;
}
