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

//    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_SHIPMENT_COST_INVOICE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_SHIPMENT_COST_INVOICE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_SHIPMENT_COST_INVOICE"));

//        Map<String, String> eStatus = new HashMap<>();
//        for (EStatus value : EStatus.values()) eStatus.put(value.name(), value.name());
//        request.setAttribute("Enum_EStatus", objectMapper.writeValueAsString(eStatus));

        return "shipmentCostInvoice/shipmentCostInvoice";
    }
}
