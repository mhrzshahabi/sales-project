package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DataType {

    PersianDate(1, "تاریخ فارسی"),
    GeorgianDate(2, "تاریخ میلادی"),
    Boolean(3, "درست/غلط"),
    BigDecimal(4, "عدد اعشاری"),
    Integer(6, "عدد صحیح"),
//    Long(7),
    String(8, "متن"),
    Reference(9, "ارجاع"),
    ListOfReference(10, "لیست ارجاع"),
    DynamicTable(11, "جدول"),
    TextArea(12, "متن بلند");

    private final Integer id;
    private final String nameFA;
}
