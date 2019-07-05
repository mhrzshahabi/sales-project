package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contract")
public class ContractFormController {

	@RequestMapping("/showForm")
	public String showContract() {
		return "base/contract";
	}

	@RequestMapping("/print/{type}")
	public void printContract(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
