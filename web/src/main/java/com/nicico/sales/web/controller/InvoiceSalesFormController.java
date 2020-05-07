package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.service.InvoiceSalesItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletResponse;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import com.nicico.copper.common.util.date.DateUtil;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceSales")
public class InvoiceSalesFormController {

    private final ReportUtil reportUtil;
    private final DateUtil dateUtil;
    private final InvoiceSalesItemService itemService;

    @RequestMapping("/showForm")
    public String showBank() {
        return "shipment/invoiceSales";
    }



    @Loggable
    @RequestMapping("/print/{type}/{rowId}")
    public void ExportToPDF(HttpServletResponse response , @PathVariable String type , @PathVariable Long rowId )  throws Exception {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        dtf.format(PersianDate.now());
        String dateroz = PersianDate.now().format(dtf);
        Map<String , Object > params = new HashMap<>();
        params.put("ID" , rowId);
        params.put(ConstantVARs.REPORT_TYPE , type);
        params.put("datetime" ,dateroz );
//        double a1 = itemService.get(rowId).getTotalPrice();
//        params.put("sum_number_to_string" , dateUtil.numberToString(String.format("%.0f" , a1)));
        reportUtil.export("/reports/invoiceSales.jasper", params, response);

    }

}
