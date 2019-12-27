package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/parameters")
public class ParametersFormController {

    @RequestMapping("/showForm")
    public String showParameters() {
        return "base/parameters";
    }
}
