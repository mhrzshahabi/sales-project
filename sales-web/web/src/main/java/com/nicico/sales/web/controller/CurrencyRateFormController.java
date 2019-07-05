package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/currencyRate")
public class CurrencyRateFormController {

	@RequestMapping("/showForm")
	public String showCurrencyRate() {
		return "base/currencyRate";
	}

	@RequestMapping("/print/{type}")
	public void printCurrencyRate(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
