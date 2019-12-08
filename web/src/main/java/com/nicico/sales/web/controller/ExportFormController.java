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
@RequestMapping("/export")
public class ExportFormController {

	private final ReportUtil report;

	@RequestMapping("/showForm")
	public String showExport() {
		return "base/export";
	}

	@RequestMapping("/print/{type}")
	public void printExport(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
	@RequestMapping("/print/{type}/{year}")
	public void printExport(HttpServletResponse response, @PathVariable String type, @PathVariable String year) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put(ConstantVARs.REPORT_TYPE, type);
		params.put("year", year);
		report.export("/reports/export.jasper", params, response);
	}
}
