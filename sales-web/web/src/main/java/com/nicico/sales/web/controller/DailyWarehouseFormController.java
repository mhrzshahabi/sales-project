package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/dailyWarehouse")
public class DailyWarehouseFormController {

	@RequestMapping("/showForm")
	public String showDailyWarehouse() {
		return "base/dailyWarehouse";
	}

	@RequestMapping("/print/{type}")
	public void printDailyWarehouse(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
