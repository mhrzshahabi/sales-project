package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseCadItem")
public class WarehouseCadItemFormController {

    @RequestMapping("/showForm")
    public String showWarehouseCadItem() {
        return "base/warehouseCadItem";
    }

}
