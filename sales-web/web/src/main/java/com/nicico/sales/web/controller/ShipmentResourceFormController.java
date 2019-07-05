package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentResource")
public class ShipmentResourceFormController {

	@RequestMapping("/showForm")
	public String showShipmentResource() {
		return "base/shipmentResource";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentResource(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
