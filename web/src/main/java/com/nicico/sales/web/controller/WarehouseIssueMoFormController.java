package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseIssueMo")
public class WarehouseIssueMoFormController {

    @RequestMapping("/showForm")
    public String showWarehouseIssueMo() {
        return "product/warehouseIssueMo";
    }
}
