package com.nicico.sales.web.controller.base2;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/unit")
public class UnitFormController {

    @RequestMapping("/showForm")
    public String show() {

        return "base/unit";
    }
}
