package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CommercialRole {

    Buyer(1),
    Seller(2),
    AgentBuyer(3),
    AgentSeller(4),
    Transporter(5),
    Shipper(6),
    Inspector(7),
    Insurancer(8);

    private final Integer id;
}
