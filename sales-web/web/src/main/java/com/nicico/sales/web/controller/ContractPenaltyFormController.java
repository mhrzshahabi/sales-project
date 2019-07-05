package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractPenalty")
public class ContractPenaltyFormController {

	@RequestMapping("/showForm")
	public String showContractPenalty() {
		return "base/contractPenalty";
	}

	@RequestMapping("/print/{type}")
	public void printContractPenalty(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
