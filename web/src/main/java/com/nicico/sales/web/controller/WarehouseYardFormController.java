package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseYard")
public class WarehouseYardFormController {

    @RequestMapping("/showForm")
    public String showWarehouseYard() {
        return "prodcut/warehouseYard";
    }
}
