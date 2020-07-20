package com.nicico.sales.web.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.service.RemittanceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/remittance-detail")
@Slf4j
public class RemittanceDetailFormController {
    private final RemittanceService remittanceService;
    private final ReportUtil reportUtil;

    //
    @RequestMapping("/showForm")
    public String showWarehouseCad() {
        return "product/remittance-detail";
    }
//
//    @RequestMapping("/showWarehouseCadForm")
//    public String showWarehouseCadForm() {
//        return "product/warehouseCad_Bijack";
//    }
//
//    @RequestMapping("/showWarehouseMoForm")
//    public String showWarehouseMoForm() {
//        return "product/warehouseMo_Bijack";
//    }
//
//    @RequestMapping("/showWarehouseConcForm")
//    public String showWarehouseConcForm() {
//        return "product/warehouseConc_Bijack";
//    }
//
//    @RequestMapping("/print")
//    public void ExportToExcel(@RequestParam MultiValueMap<String, String> criteria, HttpServletResponse response) throws Exception {
//        List<Object> resp = new ArrayList<>();
//        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, WarehouseCadDTO.Info.class);
//        List<WarehouseCadDTO.Info> data = iWarehouseCadService.search(provideNICICOCriteria).getResponse().getData();
//        if (data != null) resp.addAll(data);
//        String topRowTitle = criteria.getFirst("top");
//        String[] fields = criteria.getFirst("fields").split(",");
//        String[] headers = criteria.getFirst("headers").split(",");
//        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, WarehouseCadDTO.Info.class, fields, headers, true, topRowTitle);
//        makeExcelOutputUtil.makeExcelResponse(bytes, response);
//    }
//
    @Loggable
    @RequestMapping(value = {"/report"})
    public void print(@RequestParam MultiValueMap<String, String> criteria, @RequestParam MultiValueMap<String, String> params, HttpServletResponse response) throws Exception {
        Map<String, Object> parameters = new HashMap<>(params);
        parameters.put(ConstantVARs.REPORT_TYPE, params.get("type").get(0));
        final JsonDataSource print = remittanceService.print(criteria);
        reportUtil.export("/reports/remittance.jasper", parameters, print, response);
    }
//
}

