package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/paymentOptionContract")
public class PaymentOptionContractFormController {

	@RequestMapping("/showForm")
	public String showPaymentOptionContract() {
		return "base/paymentOptionContract";
	}

	@RequestMapping("/print/{type}")
	public void printPaymentOptionContract(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
