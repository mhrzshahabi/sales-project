package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/bolHeader")
public class BolHeaderFormController {

	@RequestMapping("/showForm")
	public String showBolHeader() {
		return "base/bolHeader";
	}

	@RequestMapping("/print/{type}")
	public void printBolHeader(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
