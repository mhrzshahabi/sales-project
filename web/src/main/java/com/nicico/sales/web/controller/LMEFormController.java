package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/LME")
public class LMEFormController {

    @RequestMapping("/showForm")
    public String showLME() {
        return "base/LME";
    }
}
