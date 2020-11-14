package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SymbolUnit {

    // Percent
    PERCENT     (1),

    // Weight
    TON(2),
    BARREL(4),
    KG(8),
    WMT(16),
    MT(32),
    DMT(64),
    KGS(128),
    LB(256),
    TR_OZ(512),
    GRAMS(1024),
    L(1056),
    PPM(1536),

    // Class
    PACKAGE(2048),
    SHEET(4096),
    PALLETS(8192),
    BUNDLE(16384),
    GUNNY(32768),
    SKID(65536),
    BULK(131072),
    BAR(196608),
    // Finance
    £(262144),
    ¢(524288),
    ¥(1048576),
    ریال(2097152),
    $(4194304),
    €(8388608),

    // Combination
    US_MT(4194336),
    US_LB       (4194560),
    US_TR_OZ    (4194816),
    GRAMS_DMT   (1088);

    private final Integer id;
}
