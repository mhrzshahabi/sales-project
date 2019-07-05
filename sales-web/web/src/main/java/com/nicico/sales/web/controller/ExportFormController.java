package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/export")
public class ExportFormController {

	@RequestMapping("/showForm")
	public String showExport() {
		return "base/export";
	}

	@RequestMapping("/print/{type}")
	public void printExport(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
