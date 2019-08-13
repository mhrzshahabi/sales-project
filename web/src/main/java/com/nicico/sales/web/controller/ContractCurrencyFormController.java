package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contractCurrency")
public class ContractCurrencyFormController {

	@RequestMapping("/showForm")
	public String showContractCurrency() {
		return "base/contractCurrency";
	}
}
