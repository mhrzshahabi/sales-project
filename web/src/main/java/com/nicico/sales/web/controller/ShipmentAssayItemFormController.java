package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentAssayItem")
public class ShipmentAssayItemFormController {

    @RequestMapping("/showForm")
    public String showShipmentAssayItem() {
        return "base/shipmentAssayItem";
    }
}
