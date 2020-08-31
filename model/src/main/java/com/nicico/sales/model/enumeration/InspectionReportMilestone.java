package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum InspectionReportMilestone {

    Source(1),
    Destination(2),
    Umpire(3);

    private final Integer id;
}
