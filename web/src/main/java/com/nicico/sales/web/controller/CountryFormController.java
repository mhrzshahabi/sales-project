package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/country")
public class CountryFormController {

	@RequestMapping("/showForm")
	public String showCountry() {
		return "base/country";
	}
}
