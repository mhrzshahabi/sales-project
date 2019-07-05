package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/feature")
public class FeatureFormController {

	@RequestMapping("/showForm")
	public String showFeature() {
		return "base/feature";
	}

	@RequestMapping("/print/{type}")
	public void printFeature(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
