package com.nicico.sales.web.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/analysisMo")
public class AnalysisMoFormController {

    @RequestMapping("/showForm")
    public String analyzeMethod() {
        return "analysisMo/analysisMo";
    }

}
