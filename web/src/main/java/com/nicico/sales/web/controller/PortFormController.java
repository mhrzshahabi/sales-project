package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/port")
public class PortFormController {

	@RequestMapping("/showForm")
	public String showPort() {
		return "base/port";
	}

	@RequestMapping("/print/{type}")
	public void printPort(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
