package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/instruction")
public class InstructionFormController {

	@RequestMapping("/showForm")
	public String showInstruction() {
		return "base/instruction";
	}

	@RequestMapping("/print/{type}")
	public void printInstruction(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
