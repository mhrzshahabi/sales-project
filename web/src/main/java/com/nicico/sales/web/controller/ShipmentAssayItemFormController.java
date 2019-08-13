package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentAssayItem")
public class ShipmentAssayItemFormController {

	@RequestMapping("/showForm")
	public String showShipmentAssayItem() {
		return "base/shipmentAssayItem";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentAssayItem(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
