package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/glossary")
public class GlossaryFormController {

	@RequestMapping("/showForm")
	public String showGlossary() {
		return "base/glossary";
	}

	@RequestMapping("/print/{type}")
	public void printGlossary(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
