package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentMoisture")
public class ShipmentMoistureFormController {

    @RequestMapping("/showForm")
    public String showShipmentMoistureHeader() {
        return "shipment/shipmentMoisture";
    }
}
