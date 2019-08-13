package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/provisionalInvoice")
public class ProvisionalInvoiceFormController {

	@RequestMapping("/showForm")
	public String showProvisionalInvoice() {
		return "base/provisionalInvoice";
	}

	@RequestMapping("/print/{type}")
	public void printProvisionalInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
