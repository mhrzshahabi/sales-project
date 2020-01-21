package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/material")
public class MaterialFormController {
    @RequestMapping("/showForm")
    public String showMaterial() {
        return "base/material";
    }
}
