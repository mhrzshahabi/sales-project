package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/contactAccount")
public class ContactAccountFormController {

	@RequestMapping("/showForm")
	public String showContactAccount() {
		return "base/contactAccount";
	}

	@RequestMapping("/print/{type}")
	public void printContactAccount(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
