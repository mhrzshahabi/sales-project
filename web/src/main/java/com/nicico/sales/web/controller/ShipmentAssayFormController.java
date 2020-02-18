package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentAssay")
public class ShipmentAssayFormController {

    @RequestMapping("/showForm")
    public String showShipmentAssayHeader() {
        return "shipment/shipmentAssay";
    }
}
