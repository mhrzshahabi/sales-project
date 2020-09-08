package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.security.Security;

@RequiredArgsConstructor
@Controller
@RequestMapping("/costDuty")
public class ShipmentCostDutyFormController {

    @RequestMapping("/showForm")
    public String showParameters(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_SHIPMENT_COST_DUTY"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_SHIPMENT_COST_DUTY"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_SHIPMENT_COST_DUTY"));
        request.setAttribute("a_entity",  SecurityUtil.hasAuthority("A_SHIPMENT_COST_DUTY"));
        request.setAttribute("i_entity",  SecurityUtil.hasAuthority("I_SHIPMENT_COST_DUTY"));
        request.setAttribute("f_entity",  SecurityUtil.hasAuthority("F_SHIPMENT_COST_DUTY"));
        request.setAttribute("o_entity",  SecurityUtil.hasAuthority("O_SHIPMENT_COST_DUTY"));

        return "base/shipmentCostDuty/shipmentCostDuty";
    }
}
