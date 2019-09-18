package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

	@RequestMapping("/showForm/{shipmentId}/{invoiceId}")
	public String showInvoiceMolybdenum(HttpServletResponse response, ModelMap map, @PathVariable String shipmentId, @PathVariable String invoiceId) {
		map.put("shipmentId",shipmentId);
		map.put("invoiceId",invoiceId);
		return "shipment/invoiceMolybdenum";
	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
