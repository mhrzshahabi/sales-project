package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/shipmentInquiry")
public class ShipmentInquiryFormController {

	@RequestMapping("/showForm")
	public String showShipmentInquiry() {
		return "base/shipmentInquiry";
	}

	@RequestMapping("/print/{type}")
	public void printShipmentInquiry(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
