package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentContract")
public class ShipmentContractFormController {

	@RequestMapping("/showForm")
	public String showShipmentContract() {
		return "shipment/shipmentContract";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentContract(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
