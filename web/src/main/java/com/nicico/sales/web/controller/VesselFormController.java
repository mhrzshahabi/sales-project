package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/vessel")
public class VesselFormController {

    @RequestMapping("/showForm")
    public String showTerm(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_VESSEL"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_VESSEL"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_VESSEL"));
        return "vessel/vessel";
    }
}
