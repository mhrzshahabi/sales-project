package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contact")
public class ContactFormController {

    @RequestMapping("/showForm")
    public String showContact() {
        return "base/contact";
    }
}
