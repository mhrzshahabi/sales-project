package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/unit")
public class UnitFormController {

	@RequestMapping("/showForm")
	public String showUnit() {
		return "base/unit";
	}

	@RequestMapping("/print/{type}")
	public void printUnit(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
