package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractAddendum")
public class ContractAddendumFormController {

	@RequestMapping("/showForm")
	public String showContractAddendum() {
		return "base/contractAddendum";
	}

	@RequestMapping("/print/{type}")
	public void printContractAddendum(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
