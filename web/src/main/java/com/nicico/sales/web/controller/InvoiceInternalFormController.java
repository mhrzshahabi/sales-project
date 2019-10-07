package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.iservice.IInvoiceInternalService;
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
@RequestMapping("/invoiceInternal")
public class InvoiceInternalFormController {

    private final ReportUtil reportUtil;
    private final IInvoiceInternalService invoiceInternalService;
    private final DateUtil dateUtil;

    @RequestMapping("/showForm")
    public String showInvoiceInternal() {
        return "shipment/invoiceInternal";
    }

    <T> String nvl(T f) {
        return f == null ? "0.0" : f.toString();
    }

    @RequestMapping("/print/{type}/{rowId}")
    public void printInvoice(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("ID", rowId);
        Float mablaghKol = invoiceInternalService.get(Long.valueOf(rowId)).getMablaghKol();
        Float payForAvarezMalyat = invoiceInternalService.get(Long.valueOf(rowId)).getPayForAvarezMalyat();
        Float sum = mablaghKol + payForAvarezMalyat;
        params.put("sum_number_to_string", dateUtil.numberToString(String.format ("%.0f", sum)));
        reportUtil.export("/reports/invoice_dakheli.jasper", params, response);
    }
}
