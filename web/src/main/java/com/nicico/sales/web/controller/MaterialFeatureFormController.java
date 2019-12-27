package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/materialFeature")
public class MaterialFeatureFormController {

    @RequestMapping("/showForm")
    public String showMaterialFeature() {
        return "base/materialFeature";
    }
}
