package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/groups")
public class GroupsFormController {

    @RequestMapping("/showForm")
    public String showGroups() {
        return "base/groups";
    }
}
