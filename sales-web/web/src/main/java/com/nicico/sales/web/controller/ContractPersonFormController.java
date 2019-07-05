package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractPerson")
public class ContractPersonFormController {

	@RequestMapping("/showForm")
	public String showContractPerson() {
		return "base/contractPerson";
	}

	@RequestMapping("/print/{type}")
	public void printContractPerson(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
