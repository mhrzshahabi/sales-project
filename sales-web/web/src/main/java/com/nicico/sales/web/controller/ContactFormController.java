package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contact")
public class ContactFormController {

    @RequestMapping("/showForm")
    public String showContact() {
        return "base/contact";
    }

    @RequestMapping("/print/{type}")
    public void printContact(HttpServletResponse response, @PathVariable String type) throws Exception {
    }
}
