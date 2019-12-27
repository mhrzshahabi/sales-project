package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/groupsPerson")
public class GroupsPersonFormController {

    @RequestMapping("/showForm")
    public String showGroupsPerson() {
        return "base/groupsPerson";
    }
}
