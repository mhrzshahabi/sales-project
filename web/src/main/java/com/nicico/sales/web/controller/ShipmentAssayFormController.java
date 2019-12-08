package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentAssay")
public class ShipmentAssayFormController {

	@RequestMapping("/showForm")
	public String showShipmentAssayHeader() {
		return "shipment/shipmentAssay";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentAssayHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
