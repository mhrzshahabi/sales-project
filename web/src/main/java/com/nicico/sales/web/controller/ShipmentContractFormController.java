package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentContract")
public class ShipmentContractFormController {

    @RequestMapping("/showForm")
    public String showShipmentContract() {
        return "shipment/shipmentContract";
    }
}
