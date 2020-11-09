package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum WeighingType {

//    DraftSurvey(1),
//    WeighBridge(2);
//
//    private final Integer id;

    DraftSurvey(1, "Draft Survey", "درفت"),
    WeighBridge(2, "Weight Bridge", "وزن");

    private final Integer id;
    private final String nameEN;
    private final String nameFA;


    public String getNameEN() {
        return this.nameEN;
    }

    public String getNameFA() {
        return this.nameFA;
    }
}
