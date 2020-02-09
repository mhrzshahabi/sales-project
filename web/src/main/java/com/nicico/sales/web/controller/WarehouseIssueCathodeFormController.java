package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseIssueCathode")
public class WarehouseIssueCathodeFormController {

    @RequestMapping("/showForm")
    public String showWarehouseIssueCathode() {
        return "prodcut/warehouseIssueCathode";
    }
}
