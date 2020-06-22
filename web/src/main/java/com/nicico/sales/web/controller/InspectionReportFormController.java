package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/inspectionReport")
public class InspectionReportFormController {

    @RequestMapping("/showForm")
    public String showTerm(HttpServletRequest request) {

//        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_INSPECTION_REPORT"));
//        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_INSPECTION_REPORT"));
//        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_INSPECTION_REPORT"));
        return "inspectionReport/inspectionReport";
    }
}
