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
    BUNDLE(11),
    PERCENT(12),
    GRAMS_DMT(13),
    WMT(14),
    MT(15),
    DMT(16),
    US_MT(17),
    US_TR_OZ(18),
    US_LB(19),
    KGS(20);
    private final Integer id;

    @Getter
    @RequiredArgsConstructor
    public enum SymbolCUR {
        $(21),
        CNH(22),
        €(23),
        £(24),
        ¢(25),
        ¥(26),
        ریال(27);
        private final Integer id;
    }
}
