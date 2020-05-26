package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.NumberConvertor;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.model.entities.base.InvoiceSalesItem;
import com.nicico.sales.repository.InvoiceSalesItemDAO;
import com.nicico.sales.service.InvoiceSalesService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceSales")
public class InvoiceSalesFormController {

    private final ReportUtil reportUtil;
    private final InvoiceSalesService invoiceSalesService;
    private final InvoiceSalesItemDAO invoiceSalesItemDAO;
    private final NumberConvertor numberConvertor;

    @RequestMapping("/showForm")
    public String showBank() {
        return "shipment/invoiceSales";
    }


    @Loggable

    @RequestMapping("/print/{type}/{rowId}")
    public void ExportToPDF(HttpServletResponse response, @PathVariable String type, @PathVariable Long rowId) throws Exception {

        /*Date Today*/
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        dtf.format(PersianDate.now());
        String today = PersianDate.now().format(dtf);

        Map<String, Object> params = getParams();

        /*Set Params*/
        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("datetime", today);

        InvoiceSalesDTO.Info info = invoiceSalesService.get(rowId);
        List<InvoiceSalesItem> invoiceSalesItems = invoiceSalesItemDAO.findByInvoiceSalesId(info.getId());

        long sum = getSum();
        for (InvoiceSalesItem invoiceSalesItem : invoiceSalesItems) {sum = getSum(sum, invoiceSalesItem);  }

        params.put("sumToString", numberConvertor.toPersianWord(String.valueOf(sum), "ریال"));
        reportUtil.export("/reports/invoiceSales.jasper", params, response);
    }

    private long getSum() {return 0L;}
    private HashMap<String, Object> getParams() {return new HashMap<>();}
    private long getSum(long sum, InvoiceSalesItem invoiceSalesItem) { return sum + invoiceSalesItem.getTotalPrice();}
}
