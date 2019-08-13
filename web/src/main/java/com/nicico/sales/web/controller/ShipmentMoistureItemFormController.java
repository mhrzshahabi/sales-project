package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentMoistureItem")
public class ShipmentMoistureItemFormController {

	@RequestMapping("/showForm")
	public String showShipmentMoistureItem() {
		return "base/shipmentMoistureItem";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentMoistureItem(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
