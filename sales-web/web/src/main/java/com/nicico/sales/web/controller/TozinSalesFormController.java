package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/tozinSales")
public class TozinSalesFormController {

	@RequestMapping("/showForm")
	public String showTozinSales() {
		return "base/tozinSales";
	}

	@RequestMapping("/print/{type}")
	public void printTozinSales(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
