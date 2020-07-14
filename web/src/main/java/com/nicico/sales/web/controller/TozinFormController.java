package com.nicico.sales.web.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.TozinLite;
import com.nicico.sales.repository.TozinLiteDAO;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tozin")
@Slf4j
public class TozinFormController {

    private final ObjectMapper objectMapper;
    private final SpecListUtil specListUtil;
    private final ITozinService iTozinService;
    private final MakeExcelOutputUtil makeExcelOutputUtil;
    private final ReportUtil reportUtil;
    private final TozinLiteDAO tozinDAO;

    @RequestMapping("/showOnWayProductForm")
    public String showOnWayProductForm() {
        return "product/onWayProduct";
    }

    @RequestMapping("/between-complex-transfer")
    public String betweenComplexTransfer() {
        return "product/betweenComplexTransfer";
    }

    @Loggable
    @RequestMapping("/print")
    public void ExportToExcel(@RequestParam MultiValueMap<String, String> criteria, HttpServletResponse response) throws Exception {
        List<Object> resp = new ArrayList<>();
        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(criteria, TozinDTO.Info.class);
        List<TozinDTO.Info> data = iTozinService.searchTozin(provideNICICOCriteria).getResponse().getData();
        if (data != null) resp.addAll(data);
        String topRowTitle = criteria.getFirst("top");
        String[] fields = criteria.getFirst("fields").split(",");
        String[] headers = criteria.getFirst("headers").split(",");
        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, TozinDTO.Info.class, fields, headers, true, topRowTitle);
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }

    @Loggable
    @RequestMapping("/report")
    public void ExportThinOnWay(@RequestParam MultiValueMap<String, String> params, HttpServletResponse response) throws Exception {
        Map<String, Object> parameters = new HashMap<>(params);
        parameters.put("dateaval", params.get("dateaval").get(0));
        parameters.put("datedovom", params.get("datedovom").get(0));
        parameters.put("kala", params.get("kala").get(0));
        parameters.put("tolid", params.get("tolid").get(0));
//        parameters.put("haml", params.get("haml").get(0));
        parameters.put(ConstantVARs.REPORT_TYPE, params.get("type").get(0));
        NICICOCriteria provideNICICOCriteria = specListUtil.provideNICICOCriteria(params, TozinDTO.Info.class);
        List<TozinDTO.Info> data = iTozinService.searchTozin(provideNICICOCriteria).getResponse().getData();
        if (data == null) throw new NotFoundException();
        final List<TozinDTO.PDF> dataa = Arrays.asList(objectMapper.convertValue(data, TozinDTO.PDF[].class));
        final Set<TozinLite> drivers = tozinDAO.findAllByTozinIdIn(dataa.stream().map(TozinDTO::getTozinId).collect(Collectors.toSet()));
        dataa.stream().forEach(t -> {
            t.setDriverName(drivers.stream().filter(d -> d.getTozinId().equals(t.getTozinId())).findAny().get().getDriverName());
        });
        Map<String, List<TozinDTO.Info>> content = new HashMap() {{
            put("content", dataa);
        }};
        final String jsonData = objectMapper.writeValueAsString(content);
//        String jsonData = "{" + "\"content\": " + objectMapper.writeValueAsString(data) + "}";
        JsonDataSource jsonDataSource = new JsonDataSource(new ByteArrayInputStream(jsonData.getBytes(StandardCharsets.UTF_8)));
        this.reportUtil.export("/reports/OnWayMo.jasper", parameters, jsonDataSource, response);
    }

}



