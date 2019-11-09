package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/rate")
public class RateFormController {
    private final ReportUtil report;

    @RequestMapping("/showForm")
    public String showRate() {
        return "base/rate";
    }


    @RequestMapping("/print/{type}")
    public void printTblRate(HttpServletResponse response, @PathVariable String type) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        report.export("/reports/rate.jasper", params, response);

    }
}
