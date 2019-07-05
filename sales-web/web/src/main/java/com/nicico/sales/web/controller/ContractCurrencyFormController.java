package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractCurrency")
public class ContractCurrencyFormController {

	@RequestMapping("/showForm")
	public String showContractCurrency() {
		return "base/contractCurrency";
	}

	@RequestMapping("/print/{type}")
	public void printContractCurrency(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
