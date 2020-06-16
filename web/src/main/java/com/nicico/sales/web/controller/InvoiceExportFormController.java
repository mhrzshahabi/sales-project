package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice-export")
public class InvoiceExportFormController {

    @RequestMapping("/showForm")
    public String showBank() {
        return "shipment/invoiceExport";
    }

}
