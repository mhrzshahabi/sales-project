package com.nicico.sales.web.controller;

import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseIssueCons")
public class WarehouseIssueConsFormController {

    private final ReportUtil reportUtil;

    @RequestMapping("/showForm")
    public String showWarehouseIssueCons() {
        return "base/warehouseIssueCons";
    }
}
