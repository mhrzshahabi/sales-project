package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/dccView")
public class DCCViewFormController {

	@RequestMapping("/showForm")
	public String showDCC() {
		return "base/dccView";
	}

	@RequestMapping("/print/{type}")
	public void printDCC(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
