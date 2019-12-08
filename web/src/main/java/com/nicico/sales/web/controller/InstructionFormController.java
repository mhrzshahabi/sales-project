package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/instruction")
public class InstructionFormController {

	private final ReportUtil report;

	@RequestMapping("/showForm")
	public String showInstruction() {
		return "base/instruction";
	}

	@RequestMapping("/print/{type}")
    public void printInstruction(HttpServletResponse response, @PathVariable String type) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        report.export("/reports/instruction.jasper", params, response);
    }
}
