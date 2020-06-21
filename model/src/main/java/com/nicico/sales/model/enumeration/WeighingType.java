package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum WeighingType {

    DraftSurvey(1),
    WeighBridge(2);

    private final Integer id;
}
