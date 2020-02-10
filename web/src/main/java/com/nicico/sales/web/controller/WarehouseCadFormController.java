package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.dto.WarehouseCadDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.iservice.IWarehouseCadService;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import static com.nicico.sales.web.controller.ShipmentFormController.replacePOI;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseCad")
public class WarehouseCadFormController {

    private final SpecListUtil specListUtil;
    private final IWarehouseCadService iWarehouseCadService;
    private final MakeExcelOutputUtil makeExcelOutputUtil;

    @RequestMapping("/showForm")
    public String showWarehouseCad() {
        return "product/warehouseCad";
    }

    @RequestMapping("/showWarehouseCadForm")
    public String showWarehouseCadForm() {
        return "product/warehouseCad_Bijack";
    }

    @RequestMapping("/showWarehouseMoForm")
    public String showWarehouseMoForm() {
        return "product/warehouseMo_Bijack";
    }

    @RequestMapping("/showWarehouseConcForm")
    public String showWarehouseConcForm() {
        return "product/warehouseConc_Bijack";
    }

    @RequestMapping("/print")
    public void ExportToExcel(@RequestParam MultiValueMap<String, String> criteria, HttpServletResponse response) throws Exception {
        List<Object> resp = new ArrayList<>();
        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, WarehouseCadDTO.Info.class);
        List<WarehouseCadDTO.Info> data = iWarehouseCadService.search(provideNICICOCriteria).getResponse().getData();
        if (data != null) resp.addAll(data);
        String topRowTitle = criteria.getFirst("top");
        String[] fields = criteria.getFirst("fields").split(",");
        String[] headers = criteria.getFirst("headers").split(",");
        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, TozinDTO.Info.class, fields, headers, true, topRowTitle);
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }
}
