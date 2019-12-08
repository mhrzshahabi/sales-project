package com.nicico.sales.web.controller;

import com.google.gson.JsonObject;
import com.nicico.sales.iservice.ICreateReportService;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.util.ResultSetConverterTest;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JsonDataSource;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/dailyReportBandarAbbas")
public class DailyReportBandarAbbasFormController {

    private final ResultSetConverterTest resultSetConverter;
    private final ICreateReportService createReportService;

    @RequestMapping("/showForm")
    public String showDailyReportBandarAbbas() {
        return "report/dailyReportBandarAbbas";
    }

    @RequestMapping("/print/{type}")
    public void printDailyReportBandarAbbas(
            @PathVariable String type,
            @RequestParam(name = "toDay") String toDay,
            @RequestParam(name = "warehouse") String warehouse,
            HttpServletResponse response) {

        try {
            Map<String, Object> parametersMap = new HashMap<>();
            parametersMap.put("logo_nicico", "C:\\upload\\report-logo\\nicico-logo.png");
            List<WholeDto> list = createReportService.createReport(toDay, warehouse);
            // List<Object[]> list = dailyReportBandarAbbasService.findByDateAndWarehouse(toDay, warehouse);
            List<JsonObject> jsonArr = resultSetConverter.toJsonArray(list, new String[]
                    {"warehouse", "toDay", "descp", "plant", "packingType", "amountDay",
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
