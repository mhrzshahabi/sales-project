package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipmentHeader")
public class ShipmentHeaderFormController {

	@RequestMapping("/showForm")
	public String showShipmentHeader() {
		return "base/shipmentHeader";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
