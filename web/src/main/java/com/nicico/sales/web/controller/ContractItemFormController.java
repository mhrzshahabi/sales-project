package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractItem")
public class ContractItemFormController {

	@RequestMapping("/showForm")
	public String showContractItem() {
		return "base/contractItem";
	}

	@RequestMapping("/print/{type}")
	public void printContractItem(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
