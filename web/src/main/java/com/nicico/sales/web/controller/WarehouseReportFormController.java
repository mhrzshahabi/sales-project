package com.nicico.sales.web.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouse-report")
public class WarehouseReportFormController {

    private final ReportUtil reportUtil;

    //**********************************************************************************************************************

    @RequestMapping("/show-report-form")
    public String showReportContract() {
        return "warehouse-report/contract-report";
    }

    //**********************************************************************************************************************

    private static XWPFDocument replaceDynamicTable(XWPFDocument doc, List<Object[]> ll) {
        List<XWPFTable> tables = doc.getTables();
        XWPFTable table = tables.get(1);
        for (Object[] r : ll) {
            XWPFTableRow tablerow1 = table.createRow();
            List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
            XWPFParagraph para3;
            XWPFRun rh3;

            for (int i = 0; i < 5; i++) {
                para3 = tableCells1.get(i).getParagraphs().get(0);
                rh3 = para3.createRun();
                rh3.setFontSize(8);
                if (r[i] != null)
                    rh3.setText(r[i].toString());
                else
                    rh3.setText("");
            }
        }
        return doc;
    }

    public static XWPFDocument replacePOI(XWPFDocument doc, String placeHolder, String replaceText) {
        // REPLACE ALL HEADERS
        for (XWPFHeader header : doc.getHeaderList())
            replaceAllBodyElements(header.getBodyElements(), placeHolder, replaceText);
        // REPLACE BODY
        replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
        return doc;
    }

    private static void replaceAllBodyElements(List<IBodyElement> bodyElements, String placeHolder, String replaceText) {
        for (IBodyElement bodyElement : bodyElements) {
            if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0)
                replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
            if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0)
                replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
        }
    }

    private static void replaceTable(XWPFTable table, String placeHolder, String replaceText) {
        for (XWPFTableRow row : table.getRows()) {
            for (XWPFTableCell cell : row.getTableCells()) {
                for (IBodyElement bodyElement : cell.getBodyElements()) {
                    if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0) {
                        replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
                    }
                    if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0) {
                        replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
                    }
                }
            }
        }
    }

    private static void replaceParagraph(XWPFParagraph paragraph, String placeHolder, String replaceText) {
        for (XWPFRun r : paragraph.getRuns()) {
            String text = r.getText(r.getTextPosition());
            if (text != null && text.contains(placeHolder)) {
                text = text.replace(placeHolder, replaceText);
                r.setText(text, 0);
            }
        }
    }

    private static XWPFDocument replaceDynamicTable1(XWPFDocument doc, List<Object[]> ll) throws Exception {
        List<XWPFTable> tables = doc.getTables();
        XWPFTable table = tables.get(1);
        int row = 1;
        String product = "";
        Double sum = new Double("0");
        int container = 0;
        for (Object[] r : ll) {

            if (row == 1)
                product = r[3].toString();
            else if (!product.equals(r[3].toString())) {
                XWPFTableRow tablerow1 = table.createRow();
                List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
                XWPFParagraph para3;
                XWPFRun rh3;
                para3 = tableCells1.get(5).getParagraphs().get(0);
                para3.setAlignment(ParagraphAlignment.CENTER);
                rh3 = para3.createRun();
                rh3.setFontSize(8);
                rh3.setText(String.valueOf(container));

                para3 = tableCells1.get(7).getParagraphs().get(0);
                para3.setAlignment(ParagraphAlignment.CENTER);
                rh3 = para3.createRun();
                rh3.setFontSize(8);
                rh3.setText(String.valueOf(sum));

                product = r[3].toString();
                sum = 0D;
                container = 0;
                row = 1;
            }
            XWPFTableRow tablerow1 = table.createRow();
            List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
            XWPFParagraph para3;
            XWPFRun rh3;

            para3 = tableCells1.get(0).getParagraphs().get(0);
            rh3 = para3.createRun();
            rh3.setFontSize(8);
            rh3.setText(String.valueOf(row++));

            for (int i = 0; i < 9; i++) {
                para3 = tableCells1.get(i + 1).getParagraphs().get(0);
                para3.setAlignment(ParagraphAlignment.CENTER);
                rh3 = para3.createRun();
                rh3.setFontSize(8);
                if (r[i] != null)
                    rh3.setText(r[i].toString());
                else
                    rh3.setText("");
            }
            sum += new Double(r[6].toString());
            container += Integer.valueOf(r[4].toString());
        }
        if (sum.compareTo(0D) > 0) {
            XWPFTableRow tablerow1 = table.createRow();
            List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
            XWPFParagraph para3;
            XWPFRun rh3;
            para3 = tableCells1.get(5).getParagraphs().get(0);
            para3.setAlignment(ParagraphAlignment.CENTER);
            rh3 = para3.createRun();
            rh3.setFontSize(8);
            rh3.setText(String.valueOf(container));

            para3 = tableCells1.get(7).getParagraphs().get(0);
            para3.setAlignment(ParagraphAlignment.CENTER);
            rh3 = para3.createRun();
            rh3.setFontSize(8);
            rh3.setText(String.valueOf(sum));
        }

        return doc;
    }

    //**********************************************************************************************************************

    @Loggable
    @GetMapping(value = {"/warehouseStock/print/{type}/{date}"})
    public void print(HttpServletResponse response, @PathVariable String type, @PathVariable("date") String date)
            throws SQLException, IOException, JRException {
        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        Map<String, Object> params = new HashMap<>();
        params.put("dateReport", day);
        params.put(ConstantVARs.REPORT_TYPE, type);
        reportUtil.export("/reports/warehouse.jasper", params, response);
    }

    @RequestMapping("/warehouseStock/print/{name}/{type}/{date}")
    public void print(HttpServletResponse response, @PathVariable String name,
                      @PathVariable String type, @PathVariable String date) throws SQLException, IOException, JRException {
        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        Map<String, Object> params = new HashMap<>();
        params.put("dateReport", day);
        params.put(ConstantVARs.REPORT_TYPE, type);
        switch (name) {
            case "Forosh_Bargiri":
                reportUtil.export("/reports/tozin_forosh_bargiri.jasper", params, response);
                break;
            case "Kharid_Konstantere":
                reportUtil.export("/reports/tozin_kharid_konstantere.jasper", params, response);
                break;
            case "Kharid_Zaieat":
                reportUtil.export("/reports/tozin_kharid_zayeat.jasper", params, response);
                break;
            case "beyn_mojtama":
                reportUtil.export("/reports/tozin_beyn_mojtama.jasper", params, response);
                break;
        }
    }
}

//**********************************************************************************************************************