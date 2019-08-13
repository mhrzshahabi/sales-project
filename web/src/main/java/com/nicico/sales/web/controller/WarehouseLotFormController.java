package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/warehouseLot")
public class WarehouseLotFormController {

	@RequestMapping("/showForm")
	public String showWarehouseLot() {
		return "base/warehouseLot";
	}

	@RequestMapping("/print/{type}")
	public void printWarehouseLot(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
