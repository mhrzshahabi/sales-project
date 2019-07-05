package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/bank")
public class BankFormController {

	@RequestMapping("/showForm")
	public String showBank() {
		return "base/bank";
	}

	@RequestMapping("/print/{type}")
	public void printBank(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
