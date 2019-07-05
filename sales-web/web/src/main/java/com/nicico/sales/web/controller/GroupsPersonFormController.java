package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/groupsPerson")
public class GroupsPersonFormController {

	@RequestMapping("/showForm")
	public String showGroupsPerson() {
		return "base/groupsPerson";
	}

	@RequestMapping("/print/{type}")
	public void printGroupsPerson(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
