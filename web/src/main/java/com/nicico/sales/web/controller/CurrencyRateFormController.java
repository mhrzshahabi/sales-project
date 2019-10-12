package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/currencyRate")
public class CurrencyRateFormController {

	@RequestMapping("/showForm")
	public String showCurrencyRate() {
		return "base/currencyRate";
	}

	@RequestMapping("/print/{type}")
	public void printMaterial(HttpServletResponse response, @PathVariable String type) throws Exception {
		Map<String, Object> params = new HashMap<>();
	}
}
