package com.nicico.sales.web.controller.report;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.iservice.report.IReportService;
import com.nicico.sales.model.enumeration.ReportType;
import com.nicico.sales.service.report.MappingUtil;
import com.nicico.sales.service.report.ReportService;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/report-execute")
public class ReportExecuteFormController {

    private final MappingUtil mappingUtil;
    private final ObjectMapper objectMapper;
    private final IFileService fileService;
    private final IReportService reportService;
    private final ReportUtil reportUtil;
    private final MakeExcelOutputUtil makeExcelOutputUtil;

    @RequestMapping("/show-form/{reportId}")
    public String showReport(@PathVariable Long reportId, HttpServletRequest request) throws JsonProcessingException {

        ReportDTO.Info report = reportService.get(reportId);
        request.setAttribute("Report_Criteria", report.getCriteria());
        report.setCriteria(null);
        request.setAttribute("Data_Report", objectMapper.writeValueAsString(report));
        request.setAttribute("Excel_Access", SecurityChecker.check("hasAuthority('RG_E_" + report.getPermissionBaseKey() + "')"));
        request.setAttribute("Print_Access", SecurityChecker.check("hasAuthority('RG_P_" + report.getPermissionBaseKey() + "')"));

        return "common/ReportPreviewFormUtil";
    }

    @RequestMapping("/print")
    public void print(HttpServletRequest request, HttpServletResponse response, @RequestParam MultiValueMap<String, String> criteria) throws Exception {

        String permissionKeyPrefix = "RG_P_";
        ReportDTO.Info report = reportService.checkAccess(permissionKeyPrefix, criteria.getFirst("reportId"));

        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/report-execute"));
        TotalResponse<Map<String, Object>> data = reportService.getReportData(report.getId(), baseUrl, criteria);

        Map<String, Object> parametersMap = new HashMap<>();
        parametersMap.put(ConstantVARs.REPORT_TYPE, criteria.getFirst("type"));
        HashMap value = new HashMap();
        if (data != null &&
                data.getResponse() != null &&
                data.getResponse().getData() != null &&
                data.getResponse().getData().size() > 1 &&
                report.getReportType() == ReportType.OneRecord) {

            data.getResponse().setData(data.getResponse().getData().subList(0, 1));
            data.getResponse().setEndRow(1);
            data.getResponse().setStartRow(0);
            data.getResponse().setTotalRows(1);
        }
        value.put("content", data.getResponse().getData());
        String resp = objectMapper.writeValueAsString(value);
        FileDTO.Response file = fileService.retrieve(criteria.getFirst("fileKey"));
        InputStream fileStream = new ByteArrayInputStream(file.getContent());
        InputStream dataStream = new ByteArrayInputStream(resp.getBytes(StandardCharsets.UTF_8));
        JsonDataSource jsonDataSource = new JsonDataSource(dataStream);
        reportUtil.export(fileStream, parametersMap, jsonDataSource, response);
    }

    @RequestMapping("/excel")
    public void excel(HttpServletRequest request, HttpServletResponse response, @RequestParam MultiValueMap<String, String> criteria) throws Exception {

        String permissionKeyPrefix = "RG_E_";
        ReportDTO.Info report = reportService.checkAccess(permissionKeyPrefix, criteria.getFirst("reportId"));

        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/report-execute"));
        TotalResponse<Map<String, Object>> data = reportService.getReportData(report.getId(), baseUrl, criteria);

        List<Object> resp = new ArrayList<>();
        if (data != null) resp.addAll(data.getResponse().getData());
        String[] fields = Objects.requireNonNull(criteria.getFirst("fields")).split(",");
        String[] headers = Objects.requireNonNull(criteria.getFirst("headers")).split(",");
        Class<?> returnType = reportService.getReturnType(report);
        ModelMapper modelMapper = mappingUtil.getModelMapper(returnType);
        List mappedData = resp.stream().map(item -> (Object) modelMapper.map(item, returnType)).collect(Collectors.toList());
        byte[] bytes = makeExcelOutputUtil.makeOutput(mappedData, returnType, fields, headers, true, "");
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }
}
