package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/material")
public class MaterialFormController {

	@RequestMapping("/showForm")
	public String showMaterial() {
		return "base/material";
	}

	@RequestMapping("/print/{type}")
	public void printMaterial(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
