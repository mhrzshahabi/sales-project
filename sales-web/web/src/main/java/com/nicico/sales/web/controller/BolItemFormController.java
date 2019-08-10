package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/bolItem")
public class BolItemFormController {

	@RequestMapping("/showForm")
	public String showBolItem() {
		return "base/bolItem";
	}
}
