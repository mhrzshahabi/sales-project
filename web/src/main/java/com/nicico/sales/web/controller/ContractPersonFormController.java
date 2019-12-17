package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contractPerson")
public class ContractPersonFormController {

	@RequestMapping("/showForm")
	public String showContractPerson() {
		return "contract/contractPerson";
	}
}
