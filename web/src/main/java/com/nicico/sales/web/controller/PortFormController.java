package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-port")
public class PortFormController {


    @RequestMapping("/show-form")
    public String showPort(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_PORT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_PORT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_PORT"));

        return "base/port/port";
    }
}
