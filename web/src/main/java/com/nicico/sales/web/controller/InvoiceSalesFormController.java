package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.NumberConvertor;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.model.entities.base.InvoiceSales;
import com.nicico.sales.model.entities.base.InvoiceSalesItem;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.service.InvoiceSalesItemService;
import com.nicico.sales.service.InvoiceSalesService;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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
    private final InvoiceSalesItemService invoiceSalesItemService;


    private final NumberConvertor numberConvertor;

    @RequestMapping("/showForm")
    public String showBank(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, InvoiceSales.class);

        return "shipment/invoiceSales";
    }


    @Loggable

    @RequestMapping("/print/{type}/{rowId}")
    public void ExportToPDF(HttpServletResponse response, @PathVariable String type, @PathVariable Long rowId) throws Exception {


        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        dtf.format(PersianDate.now());
        String today = PersianDate.now().format(dtf);

        Map<String, Object> params = getParams();


        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("datetime", today);

        InvoiceSalesDTO.Info info = invoiceSalesService.get(rowId);
        List<InvoiceSalesItem> invoiceSalesItems = invoiceSalesItemService.findByInvoiceSalesId(info.getId());

        long sum = getSum();
        for (InvoiceSalesItem invoiceSalesItem : invoiceSalesItems) {
            sum = getSum(sum, invoiceSalesItem);
        }

        params.put("sumToString", numberConvertor.toPersianWord(String.valueOf(sum), "????????"));
        reportUtil.export("/reports/invoiceSales.jasper", params, response);
    }

    private long getSum() {
        return 0L;
    }

    private HashMap<String, Object> getParams() {
        return new HashMap<>();
    }

    private long getSum(long sum, InvoiceSalesItem invoiceSalesItem) {
        return sum + invoiceSalesItem.getTotalPrice();
    }
}
