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
    Incoterm(5, "REFERENCE"),

    TypicalAssay(5, "LIST OF REFERENCE"),
    ContractShipment(6, "LIST OF REFERENCE"),

    Enum_RateReference(7, "REFERENCE"),
    Enum_PriceBaseReference(8, "REFERENCE");

    private final Integer id;
    private final String type;
}
