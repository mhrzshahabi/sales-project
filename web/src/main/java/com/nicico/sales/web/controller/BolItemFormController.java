package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bolItem")
public class BolItemFormController {

	@RequestMapping("/showForm")
	public String showBolItem() {
		return "base/bolItem";
	}
}