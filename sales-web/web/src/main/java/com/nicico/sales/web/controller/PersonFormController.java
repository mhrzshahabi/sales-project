package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/person")
public class PersonFormController {

	@RequestMapping("/showForm")
	public String showPerson() {
		return "base/person";
	}

	@RequestMapping("/print/{type}")
	public void printPerson(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
