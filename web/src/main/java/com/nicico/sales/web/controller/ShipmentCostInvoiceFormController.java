package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import com.nicico.sales.utility.SecurityChecker;
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

        SecurityChecker.addEntityPermissionToRequest(request, ShipmentCostInvoice.class);

        return "shipmentCostInvoice/shipmentCostInvoice";
    }
}
