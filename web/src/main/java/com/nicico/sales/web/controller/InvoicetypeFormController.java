package com.nicico.sales.web.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceType")
public class InvoicetypeFormController {

    @RequestMapping("/showForm")
    public String showInvoiceType() {
        return "invoicetype/invoiceType";
    }
}
