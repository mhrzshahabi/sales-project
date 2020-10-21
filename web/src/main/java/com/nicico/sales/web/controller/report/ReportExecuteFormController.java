package com.nicico.sales.web.controller.report;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.exception.UnAuthorizedException;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.iservice.report.IReportService;
import com.nicico.sales.utility.MakeExcelOutputUtil;
import io.minio.errors.*;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/report-execute")
public class ReportExecuteFormController {

    private final ObjectMapper objectMapper;
    private final IFileService fileService;
    private final IReportService reportService;
    private final ReportUtil reportUtil;
    private final MakeExcelOutputUtil makeExcelOutputUtil;

    @RequestMapping("/show-form/{reportId}")
    public String showReport(@PathVariable Long reportId, HttpServletRequest request) throws JsonProcessingException {

        ReportDTO.Info report = reportService.get(reportId);
        request.setAttribute("Data_Report", objectMapper.writeValueAsString(report));
        request.setAttribute("Excel_Access", SecurityUtil.hasAuthority("RG_E_" + report.getPermissionBaseKey()));
        request.setAttribute("Print_Access", SecurityUtil.hasAuthority("RG_P_" + report.getPermissionBaseKey()));

        return "common/ReportPreviewFormUtil";
    }

    @RequestMapping("/print")
    public void print(HttpServletRequest request, HttpServletResponse response, @RequestParam MultiValueMap<String, String> criteria) throws JRException, IOException, SQLException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, InternalException, XmlParserException, InvalidBucketNameException, InsufficientDataException, ErrorResponseException {

        String permissionKeyPrefix = "RG_P_";
        ReportDTO.Info report = checkAccess(permissionKeyPrefix, criteria.getFirst("reportId"));

        NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/report-execute"));
        TotalResponse<Map<String, Object>> data = reportService.getReportData(report.getId(), baseUrl, nicicoCriteria);

        Map<String, Object> parametersMap = new HashMap<>();
        parametersMap.put(ConstantVARs.REPORT_TYPE, criteria.getFirst("type"));
        String resp = objectMapper.writeValueAsString(new HashMap() {{
            put("content", data.getResponse().getData());
        }});
        FileDTO.Response file = fileService.retrieve(criteria.getFirst("fileKey"));
        JsonDataSource jsonDataSource = new JsonDataSource(new ByteArrayInputStream(resp.getBytes(StandardCharsets.UTF_8)));
        reportUtil.export(new ByteArrayInputStream(file.getContent()), parametersMap, jsonDataSource, response);
    }

    @RequestMapping("/excel")
    public void excel(HttpServletRequest request, HttpServletResponse response, @RequestParam MultiValueMap<String, String> criteria) throws Exception {

        String permissionKeyPrefix = "RG_E_";
        ReportDTO.Info report = checkAccess(permissionKeyPrefix, criteria.getFirst("reportId"));

        NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/report-execute"));
        TotalResponse<Map<String, Object>> data = reportService.getReportData(report.getId(), baseUrl, nicicoCriteria);

        List<Object> resp = new ArrayList<>();
        if (data != null) resp.addAll(data.getResponse().getData());
        String[] fields = criteria.getFirst("fields").split(",");
        String[] headers = criteria.getFirst("headers").split(",");
        byte[] bytes = makeExcelOutputUtil.makeOutput(resp, Map.class, fields, headers, true, null);
        makeExcelOutputUtil.makeExcelResponse(bytes, response);
    }

    private ReportDTO.Info checkAccess(String permissionKeyPrefix, String reportIdStr) {

        Long reportId = 0L;
        if (!StringUtils.isEmpty(reportIdStr))
            reportId = Long.valueOf(reportIdStr);

        ReportDTO.Info report = reportService.get(reportId);
        String authority = permissionKeyPrefix + report.getPermissionBaseKey();
        if (!SecurityUtil.hasAuthority(authority))
            throw new UnAuthorizedException(authority);

        return report;
    }
}
