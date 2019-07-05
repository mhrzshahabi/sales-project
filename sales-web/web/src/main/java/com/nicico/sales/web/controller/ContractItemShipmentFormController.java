package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractItemShipment")
public class ContractItemShipmentFormController {

	@RequestMapping("/showForm")
	public String showContractItemShipment() {
		return "base/contractItemShipment";
	}

	@RequestMapping("/print/{type}")
	public void printContractItemShipment(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
