package com.nicico.sales.web.controller;


import com.nicico.sales.model.entities.base.ShipmentMethod;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmentmethod")
public class ShipmentMethodFormController {

    @RequestMapping("/showForm")
    public String showShipmentMethod(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, ShipmentMethod.class);

        return "shippingmethod/shipment-method";
    }

}
