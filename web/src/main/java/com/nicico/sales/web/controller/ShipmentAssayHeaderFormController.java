package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentAssayHeader")
public class ShipmentAssayHeaderFormController {

    @RequestMapping("/showForm")
    public String showShipmentAssayHeader() {
        return "base/shipmentAssayHeader";
    }
}
