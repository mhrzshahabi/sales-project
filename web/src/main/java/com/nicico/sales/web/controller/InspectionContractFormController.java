package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/inspectionContract")
public class InspectionContractFormController {

	@RequestMapping("/showForm")
	public String showInspectionContract() {
		return "shipment/inspectionContract";
	}

	@RequestMapping("/print/{type}")
	public void printInspectionContract(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
