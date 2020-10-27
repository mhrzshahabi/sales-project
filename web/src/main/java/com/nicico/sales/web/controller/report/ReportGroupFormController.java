package com.nicico.sales.web.controller.report;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.entities.report.ReportGroup;
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
@RequestMapping("/report-group")
public class ReportGroupFormController {

    @RequestMapping("/show-form")
    public String showReport(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, ReportGroup.class);
        return "report/report-group";
    }
}
