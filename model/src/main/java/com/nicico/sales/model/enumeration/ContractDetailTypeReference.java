package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ContractDetailTypeReference {

    Bank(1, "REFERENCE"),
    Contact(2, "REFERENCE"),
    Country(3, "REFERENCE"),
    Port(4, "REFERENCE"),
    Unit(5, "REFERENCE"),
    Incoterm(6, "REFERENCE"),

    TypicalAssay(7, "LIST OF REFERENCE"),
    Discount(8, "LIST OF REFERENCE"),
    ContractShipment(9, "LIST OF REFERENCE"),

    Enum_RateReference(10, "REFERENCE"),
    Enum_PriceBaseReference(11, "REFERENCE");

    private final Integer id;
    private final String type;
}
