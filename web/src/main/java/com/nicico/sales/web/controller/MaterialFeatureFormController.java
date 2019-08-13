package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/materialFeature")
public class MaterialFeatureFormController {

	@RequestMapping("/showForm")
	public String showMaterialFeature() {
		return "base/materialFeature";
	}

	@RequestMapping("/print/{type}")
	public void printMaterialFeature(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
