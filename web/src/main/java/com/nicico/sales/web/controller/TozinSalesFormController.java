package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tozinSales")
public class TozinSalesFormController {
    private final ReportUtil reportUtil;

    @RequestMapping("/showForm")
    public String showTozinSales() {
        return "product/tozinSales";
    }

    @RequestMapping("/print/{name}/{type}/{date}")
    public void print(HttpServletResponse response, @PathVariable String name,
                                   @PathVariable String type, @PathVariable String date) throws SQLException, IOException, JRException {
        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        Map<String, Object> params = new HashMap<>();
        params.put("dateReport", day);
        params.put(ConstantVARs.REPORT_TYPE, type);
        switch (name) {
            case "Forosh_Bargiri":
                reportUtil.export("/reports/tozin_forosh_bargiri.jasper", params, response);
                break;
            case "Kharid_Konstantere":
                reportUtil.export("/reports/tozin_kharid_konstantere.jasper", params, response);
                break;
            case "Kharid_Zaieat":
                reportUtil.export("/reports/tozin_kharid_zayeat.jasper", params, response);
                break;
        }
    }
}
