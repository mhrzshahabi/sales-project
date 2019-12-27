package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/person")
public class PersonFormController {

    @RequestMapping("/showForm")
    public String showPerson() {
        return "base/person";
    }
}
