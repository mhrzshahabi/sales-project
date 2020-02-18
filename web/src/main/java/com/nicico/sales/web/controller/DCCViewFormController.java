package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dccView")
public class DCCViewFormController {

    @RequestMapping("/showForm")
    public String showDCC() {
        return "base/dccView";
    }
}
