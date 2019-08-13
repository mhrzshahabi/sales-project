package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentMoistureHeader")
public class ShipmentMoistureHeaderFormController {

	@RequestMapping("/showForm")
	public String showShipmentMoistureHeader() {
		return "base/shipmentMoistureHeader";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentMoistureHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
