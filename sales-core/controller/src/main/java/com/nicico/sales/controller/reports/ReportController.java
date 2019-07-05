package com.nicico.sales.controller.reports;

import com.google.gson.JsonObject;
import com.nicico.copper.activiti.config.json.ResultSetConverter;
import com.nicico.sales.iservice.IDailyReportBandarAbbasService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JsonDataSource;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/report")
public class ReportController {

	private final IDailyReportBandarAbbasService dailyReportBandarAbbasService;
	private final ResultSetConverter resultSetConverter;

	@PostMapping(value = {"/printDailyReportBandarAbbas"})
	public void printDetailsAccountOperations(HttpServletResponse response, @RequestHeader String toDay, @RequestHeader String warehouseNo) {

		try {
			Map<String, Object> parametersMap = new HashMap<String, Object>();
			ArrayList arrayList = new ArrayList();
			parametersMap.put("logo_nicico", "C:\\upload\\report-logo\\nicico-logo.png");

			List<Object[]> list = dailyReportBandarAbbasService.findByDateAndWarehouseNo(toDay, warehouseNo);
			List<JsonObject> jsonArr = resultSetConverter.toJsonArray(list, new String[]
					{"warehouseNo", "toDay", "descp", "plant", "packingType", "amountDay",
							"amountImportDay", "amountFirstDay", "amountExportDay", "amountReviseDay",
							"amountFirstMon", "amountImportMon", "amountExportMon", "amountReviseMon",
							"amountFirstSal", "amountImportSal", "amountExportSal", "amountReviseSal", "reviseSal", "aa"
					});

			String data = "{" +
					"\"content\": " + jsonArr.toString()
					.replace("Sarcheshmeh", "سرچشمه")
					.replaceAll("Sungun", "سونگون")
					.replaceAll("total", "مجموع")
					+ "}";
			InputStream stream = this.getClass().getResourceAsStream("/reports/dailyReportBandar.jasper");
			JsonDataSource jsonDataSource = new JsonDataSource(new ByteArrayInputStream(data.getBytes(Charset.forName("UTF-8"))));
			JasperPrint jasperPrint = JasperFillManager.fillReport(stream, parametersMap, jsonDataSource);

			response.setContentType("application/vnd.ms-excel");
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", jasperPrint.getName() + ".xls");
			response.setHeader(headerKey, headerValue);
			response.setCharacterEncoding("UTF-8");

			JRXlsxExporter xlsxExporter = new JRXlsxExporter(DefaultJasperReportsContext.getInstance());
			xlsxExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			xlsxExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(response.getOutputStream()));
			SimpleXlsxReportConfiguration reportConfigXls = new SimpleXlsxReportConfiguration();
			reportConfigXls.setSheetNames(new String[]{"Data"});
			xlsxExporter.setConfiguration(reportConfigXls);
			xlsxExporter.exportReport();
			response.getOutputStream().flush();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}