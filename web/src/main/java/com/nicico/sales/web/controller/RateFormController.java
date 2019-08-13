package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/rate")
public class RateFormController {

	@RequestMapping("/showForm")
	public String showRate() {
		return "base/rate";
	}

	@RequestMapping("/print/{type}")
	public void printRate(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
