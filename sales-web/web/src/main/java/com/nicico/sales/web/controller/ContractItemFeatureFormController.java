package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contractItemFeature")
public class ContractItemFeatureFormController {

	@RequestMapping("/showForm")
	public String showContractItemFeature() {
		return "base/contractItemFeature";
	}

	@RequestMapping("/print/{type}")
	public void printContractItemFeature(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
