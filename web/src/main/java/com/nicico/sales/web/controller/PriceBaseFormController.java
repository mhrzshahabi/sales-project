package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/price-base")
public class PriceBaseFormController {

    @RequestMapping("/showForm")
    public String showPriceBase() {
        return "priceBase/priceBase";
    }
}
