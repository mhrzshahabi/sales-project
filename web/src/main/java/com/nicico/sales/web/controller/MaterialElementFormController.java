package com.nicico.sales.web.controller;


import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/materialElement")
public class MaterialElementFormController {

    @RequestMapping("/show-form")
    public String showForm(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_MATERIAL_ELEMENT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_MATERIAL_ELEMENT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_MATERIAL_ELEMENT"));
        return "";
    }

}
