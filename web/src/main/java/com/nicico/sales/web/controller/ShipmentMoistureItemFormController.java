package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentMoistureItem")
public class ShipmentMoistureItemFormController {

    @RequestMapping("/showForm")
    public String showShipmentMoistureItem() {
        return "base/shipmentMoistureItem";
    }
}
