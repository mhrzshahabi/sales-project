package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EStatus {

    Active(1),
    DeActive(2),
    NotPrintable(4);

    private final Integer id;
}
