package com.nicico.sales.web.controller;


import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/typicalAssay")
public class TypicalAssayFormController {

    @RequestMapping("/showForm")
    public String typicalAssayMethod(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_TYPICAL_ASSAY"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_TYPICAL_ASSAY"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_TYPICAL_ASSAY"));

        return "base/typicalAssay/typicalAssay";
    }

}
