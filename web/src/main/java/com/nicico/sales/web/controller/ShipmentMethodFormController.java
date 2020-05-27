package com.nicico.sales.web.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmentmethod")
public class ShipmentMethodFormController {

    @RequestMapping("/showForm")
    public String showShipmentMethod() {
        return "shippingmethod/shipment-method";
    }

}
