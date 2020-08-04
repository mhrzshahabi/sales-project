package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ContractDetailTypeReference {

    Bank(1),
    Contact(2),
    Country(3),
    Currency(4),
    Port(6),
    Unit(7),
    ContractShipment(7),
    Enum_RateReference(8),
    Enum_PriceBaseReference(9);

    private final Integer id;
}
