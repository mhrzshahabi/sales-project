package com.nicico.sales.web.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.dto.WarehouseCadDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.iservice.IWarehouseCadService;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.model.entities.base.WarehouseCad;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.nicico.sales.web.controller.ShipmentFormController.replacePOI;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseCad")
public class WarehouseCadFormController {

    private final SpecListUtil specListUtil;
    private final IWarehouseCadService iWarehouseCadService;
    private final MakeExcelOutputUtil makeExcelOutputUtil;
    private final ReportUtil reportUtil;
    private final ObjectMapper objectMapper;


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
        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, WarehouseCadDTO.Info.class, fields, headers, true, topRowTitle);
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }

    @Loggable
    @RequestMapping(value = {"/printJasper"})
    public void print(@RequestParam MultiValueMap<String, String> criteria, @RequestParam MultiValueMap<String, String> params, HttpServletResponse response) throws Exception {

        Map<String, Object> parameters = new HashMap<>(params);
        parameters.put("mahsool" ,params.get("mahsool").get(0));
        parameters.put("vahed" , params.get("vahed").get(0));
        parameters.put("haml" , params.get("haml").get(0));
        parameters.put(ConstantVARs.REPORT_TYPE, params.get("type").get(0));

        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, WarehouseCadDTO.Info.class);
        List<WarehouseCadDTO.Info> data = iWarehouseCadService.search(provideNICICOCriteria).getResponse().getData();

        if (data == null) throw new SalesException(SalesException.ErrorType.NotFound);

        String jsonData = "{" + "\"content\": " + objectMapper.writeValueAsString(data) + "}";
        JsonDataSource jsonDataSource = new JsonDataSource(new ByteArrayInputStream(jsonData.getBytes(StandardCharsets.UTF_8)));
        reportUtil.export("/reports/Bijack.jasper", parameters, jsonDataSource, response);
    }

}
