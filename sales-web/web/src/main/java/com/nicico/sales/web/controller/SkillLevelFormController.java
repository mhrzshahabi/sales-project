package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/*
    Author: Peyman Dodangeh,
    Date : 5/15/2019,
    Time : 9:51 AM
*/

@RequiredArgsConstructor
@Controller
@RequestMapping("/skill-level")
public class SkillLevelFormController {

//    private final Report report;

	@RequestMapping("/show-form")
	public String showFiscalYear() {
		return "base/skill-level";
	}

	@RequestMapping("/print/{type}")
	public void printFiscalYear(HttpServletResponse response, @PathVariable String type) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put(ConstantVARs.REPORT_TYPE, type);
//        report.export("/reports/skillLevel.jasper", params, response);

	}

}
