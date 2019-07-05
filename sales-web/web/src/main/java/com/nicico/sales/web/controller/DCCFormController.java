package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/dcc")
public class DCCFormController {
	@GetMapping(value = {"/showForm/{dccTableName}/{dccTableId}"})
	public String showDCC(ModelMap modelMap, @PathVariable String dccTableName, @PathVariable String dccTableId) {
		modelMap.addAttribute("dccTableName", dccTableName);
		modelMap.addAttribute("dccTableId", dccTableId);
		return "base/dcc";
	}

	@RequestMapping("/print/{type}")
	public void printDCC(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
