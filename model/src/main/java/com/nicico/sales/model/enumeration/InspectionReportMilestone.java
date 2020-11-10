package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum InspectionReportMilestone {

//    Source(1),
//    Destination(2),
//    Umpire(3);
//
//    private final Integer id;

    Source(1, "Source", "مبدا"),
    Destination(2, "Destination", "مقصد"),
    Umpire(3, "Umpire", "حکم");

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
