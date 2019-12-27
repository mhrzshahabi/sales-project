package com.nicico.sales.web.controller;

import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/port")
public class PortFormController {
    private final ReportUtil report;

    @RequestMapping("/showForm")
    public String showPort() {
        return "base/port";
    }
}
