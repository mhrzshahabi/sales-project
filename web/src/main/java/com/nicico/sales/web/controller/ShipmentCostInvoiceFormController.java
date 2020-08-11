package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmentCostInvoice")
public class ShipmentCostInvoiceFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_SHIPMENT_COST_INVOICE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_SHIPMENT_COST_INVOICE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_SHIPMENT_COST_INVOICE"));
        request.setAttribute("f_entity", SecurityUtil.hasAuthority("F_SHIPMENT_COST_INVOICE"));
        request.setAttribute("a_entity", SecurityUtil.hasAuthority("A_SHIPMENT_COST_INVOICE"));
        request.setAttribute("i_entity", SecurityUtil.hasAuthority("I_SHIPMENT_COST_INVOICE"));


        return "shipmentCostInvoice/shipmentCostInvoice";
    }
}
