package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/assayInspection")
public class AssayInspectionFormController {

    @RequestMapping("/show-form")
    public String showTerm(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_ASSAY_INSPECTION"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_ASSAY_INSPECTION"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_ASSAY_INSPECTION"));

        return "assayInspection/assayInspection";
    }
}
