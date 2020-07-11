package com.nicico.sales.model.enumeration;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SymbolUnit {

    KG(1),
    TON(2),
    BARREL(3),
    LI(4),
    GUNNY(5),
    SKID(6),
    BULK(7),
    PACKAGE(8),
    SHEET(9),
    PALLETS(10),
    BUNDLE(11);

    private final Integer id;
}
