package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ReportType {

    None(1),
    OneRecord(2),
    SelectedRecords(3),
    All(4);

    private final Integer id;
}
