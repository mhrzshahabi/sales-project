package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum InspectionRateValueType {

//    ManPerDay(1),
//    PerTon(2);
//
//    private final Integer id;

    ManPerDay(1, "ManPerDay", "نفر روز"),
    PerTon(2, "PerTon", "تن");

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
