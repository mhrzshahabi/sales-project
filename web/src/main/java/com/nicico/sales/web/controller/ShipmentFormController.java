package com.nicico.sales.web.controller;

import com.nicico.copper.common.util.date.DateUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {

	@RequestMapping("/showForm")
	public String showShipment() {
		DateUtil a;
		return "shipment/shipment";
	}

	@RequestMapping("/print/{type}")
	public void printShipment(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
