package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/LME")
public class LMEFormController {

	@RequestMapping("/showForm")
	public String showLME() {
		return "base/LME";
	}

	@RequestMapping("/print/{type}")
	public void printLME(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
