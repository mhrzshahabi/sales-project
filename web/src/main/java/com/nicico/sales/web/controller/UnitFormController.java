package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/unit")
public class UnitFormController {

    @RequestMapping("/showForm")
    public String showUnit() {
        return "base/unit";
    }
}
