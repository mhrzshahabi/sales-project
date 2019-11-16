package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseIssueCathode")
public class WarehouseIssueCathodeFormController {

    private final ReportUtil reportUtil;

    @RequestMapping("/showForm")
    public String showWarehouseIssueCathode() {
        return "base/warehouseIssueCathode";
    }

    @RequestMapping("/print/{type}")
    public void print(HttpServletResponse response, @PathVariable String type) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        reportUtil.export("/reports/WarehouseIssueCathode.jasper", params, response);
    }
}
