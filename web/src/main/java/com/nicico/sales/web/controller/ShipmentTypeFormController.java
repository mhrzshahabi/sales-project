package com.nicico.sales.web.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmenttype")
public class ShipmentTypeFormController {

    @RequestMapping("/showForm")
    public String showShipmentType() {
        return "shippingtype/shipment-type";
    }


}
