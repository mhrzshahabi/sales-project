package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceSales")
public class InvoiceSalesFormController {

    @RequestMapping("/showForm")
    public String showBank() {
        return "shipment/invoiceSales";
    }

}
