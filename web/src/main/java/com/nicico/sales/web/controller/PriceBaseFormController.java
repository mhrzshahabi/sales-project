package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/price-base")
public class PriceBaseFormController {

    @RequestMapping("/showForm")
    public String showPriceBase(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_PRICE_BASE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_PRICE_BASE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_PRICE_BASE"));
        return "priceBase/priceBase";
    }
}
