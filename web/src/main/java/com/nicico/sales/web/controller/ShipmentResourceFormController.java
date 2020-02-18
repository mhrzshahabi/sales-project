package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentResource")
public class ShipmentResourceFormController {

    @RequestMapping("/showForm")
    public String showShipmentResource() {
        return "base/shipmentResource";
    }
}
