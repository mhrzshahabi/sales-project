package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/provisionalInvoice")
public class ProvisionalInvoiceFormController {

    @RequestMapping("/showForm")
    public String showProvisionalInvoice() {
        return "base/provisionalInvoice";
    }
}
