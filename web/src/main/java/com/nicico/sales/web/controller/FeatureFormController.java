package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/feature")
public class FeatureFormController {

    @RequestMapping("/showForm")
    public String showFeature() {
        return "base/feature";
    }
}
