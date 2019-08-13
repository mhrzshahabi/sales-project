package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contractAddendum")
public class ContractAddendumFormController {

	@RequestMapping("/showForm")
	public String showContractAddendum() {
		return "base/contractAddendum";
	}
}
