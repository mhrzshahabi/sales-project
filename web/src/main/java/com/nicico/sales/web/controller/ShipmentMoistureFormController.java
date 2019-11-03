package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentMoisture")
public class ShipmentMoistureFormController {

	@RequestMapping("/showForm")
	public String showShipmentMoistureHeader() {
		return "shipment/shipmentMoisture";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentMoistureHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
