package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/paymentOption")
public class PaymentOptionFormController {

	@RequestMapping("/showForm")
	public String showPaymentOption() {
		return "base/paymentOption";
	}

	@RequestMapping("/print/{type}")
	public void printPaymentOption(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
