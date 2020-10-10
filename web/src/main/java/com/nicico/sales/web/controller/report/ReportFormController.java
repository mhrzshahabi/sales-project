package com.nicico.sales.web.controller.report;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.model.enumeration.ReportType;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/report")
public class ReportFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showReport(HttpServletRequest request) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request, Report.class);

        Map<String, String> source = new HashMap<>();
        for (ReportSource value : ReportSource.values())
            source.put(value.name(), value.name());
        request.setAttribute("Enum_ReportSource", objectMapper.writeValueAsString(source));

        Map<String, String> type = new HashMap<>();
        for (ReportType value : ReportType.values())
            type.put(value.name(), value.name());
        request.setAttribute("Enum_ReportType", objectMapper.writeValueAsString(type));

        return "report/report";
    }
}
