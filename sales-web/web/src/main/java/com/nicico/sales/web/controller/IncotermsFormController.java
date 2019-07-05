package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/incoterms")
public class IncotermsFormController {

	@RequestMapping("/showForm")
	public String showIncoterms() {
		return "base/incoterms";
	}

	@RequestMapping("/print/{type}")
	public void printIncoterms(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
