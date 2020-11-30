package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EFileStatus {
    NORMAL("NORMAL"),
    DELETED("DELETED");

    // ---------------

    private final String value;
}
