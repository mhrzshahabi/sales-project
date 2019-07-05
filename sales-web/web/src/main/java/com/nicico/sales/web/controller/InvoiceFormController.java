package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

	@RequestMapping("/showForm")
	public String showInvoice() {
		return "shipment/invoice";
	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
