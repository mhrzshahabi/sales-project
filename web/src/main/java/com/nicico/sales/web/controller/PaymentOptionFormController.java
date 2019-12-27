package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/paymentOption")
public class PaymentOptionFormController {

    @RequestMapping("/showForm")
    public String showPaymentOption() {
        return "base/paymentOption";
    }
}
