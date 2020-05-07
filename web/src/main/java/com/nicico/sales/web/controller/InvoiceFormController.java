package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.service.InvoiceService;
import com.nicico.sales.service.ShipmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

    private final ReportUtil reportUtil;
    private final InvoiceService invoiceService;
    private final ShipmentService shipmentService;

    @RequestMapping("/showForm")
    public String showInvoice() {
        return "shipment/invoice";
    }

    @RequestMapping("/print/{type}/{rowId}")
    public void printInvoice(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        Long shipmentId = invoiceService.get(Long.valueOf(rowId)).getShipmentId();
        String description = shipmentService.get(shipmentId).getMaterial().getDescl();
        if (description.toLowerCase().contains("mol")) {
            reportUtil.export("/reports/Mo_Ox.jasper", params, response);
        } else if (description.toLowerCase().contains("cat")) {
            reportUtil.export("/reports/CAD.jasper", params, response);
        } else if (description.toLowerCase().contains("conc")) {
            reportUtil.export("/reports/Conc.jasper", params, response);
        }
    }
}
