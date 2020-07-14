package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/remittance-detail")
public class RemittanceDetailFormController {
    //
//    private final SpecListUtil specListUtil;
//    private final MakeExcelOutputUtil makeExcelOutputUtil;
//    private final ReportUtil reportUtil;
//    private final ObjectMapper objectMapper;
//    ModelMapper modelMapper;
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
//    @Loggable
//    @RequestMapping(value = {"/Bijack"})
//    public void print(@RequestParam MultiValueMap<String, String> criteria, @RequestParam MultiValueMap<String, String> params, HttpServletResponse response) throws Exception {
//
//        Map<String, Object> parameters = new HashMap<>(params);
//        parameters.put("mahsool", params.get("mahsool").get(0));
//        parameters.put("vahed", params.get("vahed").get(0));
//        parameters.put("haml", params.get("haml").get(0));
//        parameters.put(ConstantVARs.REPORT_TYPE, params.get("type").get(0));
//
//        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, WarehouseCadDTO.Info.class);
//        List<WarehouseCadDTO.Info> data = iWarehouseCadService.search(provideNICICOCriteria).getResponse().getData();
//
//        if (data == null) throw new SalesException(SalesException.ErrorType.NotFound);
//
//
//        String jsonData = "{" + "\"content\": " + objectMapper.writeValueAsString(data) + "}";
//        JsonDataSource jsonDataSource = new JsonDataSource(new ByteArrayInputStream(jsonData.getBytes(StandardCharsets.UTF_8)));
//        reportUtil.export("/reports/Bijack.jasper", parameters, jsonDataSource, response);
//    }
//
}