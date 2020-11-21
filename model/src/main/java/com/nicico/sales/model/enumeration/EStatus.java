package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EStatus {

    Active(1),
    DeActive(2),
    Final(4),
    SendToAcc(8),
    RemoveFromAcc(16);

    private final Integer id;
}
