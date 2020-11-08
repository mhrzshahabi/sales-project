package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.iservice.IInvoiceInternalService;
import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
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
    private static BufferedImage LOGO;

    @RequestMapping("/showForm")
    public String showInvoiceInternal(HttpServletRequest request) {

        SecurityChecker.addViewPermissionToRequest(request, ViewInternalInvoiceDocument.class);

        return "shipment/invoiceInternal";
    }

    <T> String nvl(T f) {
        return f == null ? "0.0" : f.toString();
    }

    @RequestMapping("/print/{type}/{rowId}")
    public void printInvoice(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        LOGO = ImageIO.read(ReportUtil.class.getResourceAsStream("/reports/report-logo/nicico-logo1.png"));
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("ID", rowId);
        params.put("logo_nicico", LOGO);
        Double mablaghKol = invoiceInternalService.get(rowId).getTotalAmount();
        Double payForAvarezMalyat = invoiceInternalService.get(rowId).getTaxChargeAmount();
        Double sum = mablaghKol + payForAvarezMalyat;
        params.put("sum_number_to_string", dateUtil.numberToString(String.format("%.0f", sum)));
        reportUtil.export("/reports/invoice_dakheli.jasper", params, response);
    }
}
