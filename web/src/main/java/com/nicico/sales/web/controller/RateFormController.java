package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/rate")
public class RateFormController {

    @RequestMapping("/showForm")
    public String showRate() {
        return "base/rate";
    }
}
