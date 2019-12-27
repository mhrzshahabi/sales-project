package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseIssueCons")
public class WarehouseIssueConsFormController {

    @RequestMapping("/showForm")
    public String showWarehouseIssueCons() {
        return "base/warehouseIssueCons";
    }
}
