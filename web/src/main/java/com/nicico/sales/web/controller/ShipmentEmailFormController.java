package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentEmail")
public class ShipmentEmailFormController {

	@RequestMapping("/showForm")
	public String showShipmentEmail() {
		return "base/shipmentEmail";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentEmail(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
