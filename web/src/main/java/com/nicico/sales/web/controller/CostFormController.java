package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cost")
public class CostFormController {

    @RequestMapping("/showForm")
    public String showCost() {
        return "shipment/cost";
    }
}
