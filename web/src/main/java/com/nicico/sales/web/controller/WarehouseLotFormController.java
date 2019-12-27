package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/warehouseLot")
public class WarehouseLotFormController {

    @RequestMapping("/showForm")
    public String showWarehouseLot() {
        return "base/warehouseLot";
    }
}
