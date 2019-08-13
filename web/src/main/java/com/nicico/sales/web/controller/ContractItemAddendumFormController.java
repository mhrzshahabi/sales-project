package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractItemAddendum")
public class ContractItemAddendumFormController {

	@RequestMapping("/showForm")
	public String showContractItemAddendum() {
		return "base/contractItemAddendum";
	}

	@RequestMapping("/print/{type}")
	public void printContractItemAddendum(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
