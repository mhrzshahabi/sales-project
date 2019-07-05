package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/groups")
public class GroupsFormController {

	@RequestMapping("/showForm")
	public String showGroups() {
		return "base/groups";
	}

	@RequestMapping("/print/{type}")
	public void printGroups(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
