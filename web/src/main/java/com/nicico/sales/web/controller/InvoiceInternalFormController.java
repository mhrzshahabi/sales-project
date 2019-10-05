package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceInternal")
public class InvoiceInternalFormController {
	@RequestMapping("/showForm")
	public String showInvoiceInternal() {
		return "shipment/invoiceInternal";
	}


	<T> String nvl(T f) {
		return f == null ? "0.0" : f.toString();
	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
