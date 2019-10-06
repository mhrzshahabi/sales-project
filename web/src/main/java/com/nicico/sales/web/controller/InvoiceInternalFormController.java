package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceInternal")
public class InvoiceInternalFormController {

    private final ReportUtil reportUtil;

    @RequestMapping("/showForm")
    public String showInvoiceInternal() {
        return "shipment/invoiceInternal";
    }

    <T> String nvl(T f) {
        return f == null ? "0.0" : f.toString();
    }

    @RequestMapping("/print/{type}")
    public void printInvoice(HttpServletResponse response, @PathVariable String type, @RequestParam("rowId") String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("rowId", rowId);
        reportUtil.export("/reports/invoice_dakheli.jasper", params, response);
    }
}
