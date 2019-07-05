package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/parameters")
public class ParametersFormController {

	@RequestMapping("/showForm")
	public String showParameters() {
		return "base/parameters";
	}

	@RequestMapping("/print/{type}")
	public void printParameters(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
