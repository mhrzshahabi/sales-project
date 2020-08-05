package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/shipment-cost")
public class CostFormController {

    @RequestMapping("/show-form")
    public String showCost(HttpServletRequest request) throws JsonProcessingException {


        request.setAttribute("c_entity" , SecurityUtil.hasAuthority("C_COST"));
        request.setAttribute("u_entity" , SecurityUtil.hasAuthority("U_COST"));
        request.setAttribute("d_entity" , SecurityUtil.hasAuthority("D_COST"));

        return "shipment/cost/cost";
    }
}
