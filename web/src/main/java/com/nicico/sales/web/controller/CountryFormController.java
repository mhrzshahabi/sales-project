package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/base-country")
public class CountryFormController {

    @RequestMapping("/show-form")
    public String showCountry(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_COUNTRY"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_COUNTRY"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_COUNTRY"));

        return "base/country/country";
    }
}
