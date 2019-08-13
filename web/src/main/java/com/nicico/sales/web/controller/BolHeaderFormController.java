package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bolHeader")
public class BolHeaderFormController {

	@RequestMapping("/showForm")
	public String showBolHeader() {
		return "base/bolHeader";
	}
}
