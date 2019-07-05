package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentAssayHeader")
public class ShipmentAssayHeaderFormController {

	@RequestMapping("/showForm")
	public String showShipmentAssayHeader() {
		return "base/shipmentAssayHeader";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentAssayHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
