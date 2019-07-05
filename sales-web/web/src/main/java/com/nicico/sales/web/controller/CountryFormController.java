package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/country")
public class CountryFormController {

	@RequestMapping("/showForm")
	public String showCountry() {
		return "base/country";
	}

	@RequestMapping("/print/{type}")
	public void printCountry(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
