package com.nicico.sales.web.controller;


import com.nicico.sales.model.entities.base.ShipmentType;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmenttype")
public class ShipmentTypeFormController {

    @RequestMapping("/showForm")
    public String showShipmentType(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, ShipmentType.class);

        return "shippingtype/shipment-type";
    }


}
