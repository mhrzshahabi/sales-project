package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipmentEmail")
public class ShipmentEmailFormController {

    @RequestMapping("/showForm")
    public String showShipmentEmail() {
        return "base/shipmentEmail";
    }
}
