package com.nicico.sales.web.controller.report;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.enumeration.EFileStatus;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.model.enumeration.ReportType;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/report")
public class ReportFormController {

    private final ObjectMapper objectMapper;
    private final ResourceBundleMessageSource messageSource;


    @RequestMapping("/show-form")
    public String showReport(HttpServletRequest request) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request, Report.class);

        Map<String, String> source = getSourceEnumMap();
        request.setAttribute("Enum_ReportSource", objectMapper.writeValueAsString(source));

        Map<String, String> type = getReportTypeEnumMap();
        request.setAttribute("Enum_ReportType", objectMapper.writeValueAsString(type));

        return "report/report";
    }

    private Map<String, String> getReportTypeEnumMap() {

        Map<String, String> type = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (ReportType value : ReportType.values())
            if (value == ReportType.All)
                type.put(value.name(), messageSource.getMessage("report.reportType.all", null, locale));
            else if (value == ReportType.None)
                type.put(value.name(), messageSource.getMessage("report.reportType.none", null, locale));
            else if (value == ReportType.OneRecord)
                type.put(value.name(), messageSource.getMessage("report.reportType.one", null, locale));
            else if (value == ReportType.SelectedRecords)
                type.put(value.name(), messageSource.getMessage("report.reportType.selected", null, locale));
            else
                throw new SalesException2(ErrorType.InvalidData, null, "?????????? ???????? ?????????? ???????? ?????? ?????? ?????????? ?????????? ???????? ??????");

        return type;
    }

    private Map<String, String> getSourceEnumMap() {

        Map<String, String> source = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (ReportSource value : ReportSource.values())
            if (value == ReportSource.Rest)
                source.put(value.name(), messageSource.getMessage("report.api", null, locale));
            else if (value == ReportSource.View)
                source.put(value.name(), messageSource.getMessage("report.data-base", null, locale));
            else
                throw new SalesException2(ErrorType.InvalidData, null, "?????????? ???????? ?????????? ?????? ???????? ?????????? ?????????? ???????? ??????");

        return source;
    }

}
