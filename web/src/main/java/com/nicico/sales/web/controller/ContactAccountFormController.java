package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contactAccount")
public class ContactAccountFormController {

    @RequestMapping("/showForm")
    public String showContactAccount() {
        return "base/contactAccount";
    }
}
