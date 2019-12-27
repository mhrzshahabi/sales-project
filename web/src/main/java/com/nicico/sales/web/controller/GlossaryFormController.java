package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/glossary")
public class GlossaryFormController {

    @RequestMapping("/showForm")
    public String showGlossary() {
        return "base/glossary";
    }
}
