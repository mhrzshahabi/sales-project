package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contractPenalty")
public class ContractPenaltyFormController {

	@RequestMapping("/showForm")
	public String showContractPenalty() {
		return "base/contractPenalty";
	}
}
