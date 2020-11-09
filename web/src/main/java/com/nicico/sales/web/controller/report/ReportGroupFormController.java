package com.nicico.sales.web.controller.report;

import com.nicico.sales.model.entities.report.ReportGroup;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

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
