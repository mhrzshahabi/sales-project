package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/weightInspection")
public class WeightInspectionFormController {

    @RequestMapping("/showForm")
    public String showTerm(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_WEIGHT_INSPECTION"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_WEIGHT_INSPECTION"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_WEIGHT_INSPECTION"));
        return "weightInspection/weightInspection";
    }
}
