package com.nicico.sales.web.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import com.nicico.sales.service.RemittanceDetailService;
import com.nicico.sales.service.RemittanceService;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/remittance-detail")
@Slf4j
public class RemittanceDetailFormController {
    private final RemittanceService remittanceService;
    private final RemittanceDetailService service;
    private final ReportUtil reportUtil;
    private final SpecListUtil specListUtil;
    private final MakeExcelOutputUtil makeExcelOutputUtil;

    //
    @RequestMapping("/showForm")
    public String showWarehouseCad(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, RemittanceDetail.class);

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
    @PostMapping("/excel")
    public void ExportToExcel(@RequestParam MultiValueMap<String, String> criteria,
                              @RequestBody RemittanceDetailDTO.Excel request,
                              HttpServletResponse response) throws Exception {
        List<Object> resp = new ArrayList<>();
        if (!request.getDoesNotNeedFetch()) {
            NICICOCriteria provideNICICOCriteria = NICICOCriteria.of(criteria);
            List<RemittanceDetailDTO.Info> data = service.search(provideNICICOCriteria).getResponse().getData();
            if (data != null) resp.addAll(data);
        } else {
            final List<RemittanceDetailDTO.Info> requestRows = request.getRows();
            if (requestRows != null && requestRows.size() > 0) resp.addAll(requestRows);
        }
        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, RemittanceDetailDTO.Info.class, request.getFields(),
                request.getHeader(), true, request.getTopRowTitle());
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }

    //
    @Loggable
    @RequestMapping(value = {"/report"})
    public void print(@RequestParam MultiValueMap<String, String> criteria,
                      @RequestParam MultiValueMap<String, String> params, HttpServletResponse response) throws Exception {
        Map<String, Object> parameters = new HashMap<>(params);
        parameters.put(ConstantVARs.REPORT_TYPE, params.get("type").get(0));
        final JsonDataSource print = remittanceService.print(criteria);
        reportUtil.export("/reports/remittance.jasper", parameters, print, response);
    }
//
}

