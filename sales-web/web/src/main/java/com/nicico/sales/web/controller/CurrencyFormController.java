package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/currency")
public class CurrencyFormController {

	@RequestMapping("/showForm")
	public String showCurrency() {
		return "base/currency";
	}

	@RequestMapping("/print/{type}")
	public void printCurrency(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
