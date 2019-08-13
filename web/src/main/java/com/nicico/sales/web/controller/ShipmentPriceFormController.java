package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentPrice")
public class ShipmentPriceFormController {

	@RequestMapping("/showForm")
	public String showShipmentPrice() {
		return "base/shipmentPrice";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentPrice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
