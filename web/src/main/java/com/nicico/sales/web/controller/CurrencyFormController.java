package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/currency")
public class CurrencyFormController {

    @RequestMapping("/showForm")
    public String showCurrency() {
        return "base/currency";
    }
}
