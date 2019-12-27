package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/incoterms")
public class IncotermsFormController {

    @RequestMapping("/showForm")
    public String showIncoterms() {
        return "base/incoterms";
    }
}
