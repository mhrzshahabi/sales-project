package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.repository.WarehouseStockDAO;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseStock")
public class WarehouseStockFormController {

	private final ReportUtil reportUtil;
	private final WarehouseStockDAO warehouseStockDAO;

	@RequestMapping("/showForm")
	public String showWarehouseStock() {
		return "base/warehouseStock";
	}

	//---------------------------------------------------------------
	@Loggable
	@GetMapping(value = {"/print/{type}/{date}"})
	public void print(HttpServletResponse response, @PathVariable String type, @PathVariable("date") String date)
			throws SQLException, IOException, JRException {
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		Map<String, Object> params = new HashMap<>();
		params.put("dateReport", day);
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/warehouse.jasper", params, response);
	}

	//---------------------------------------------------------------
	@Loggable
	@GetMapping(value = {"/print-commitment/{date}"})
	public void printCommit(HttpServletResponse response, @PathVariable("date") String date)
			throws Exception {
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		InputStream stream;

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		dtf.format(PersianDate.now());

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFFont font = workbook.createFont();
			font.setFontName("B Nazanin");
			XWPFDocument doc;

			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			stream = new ClassPathResource("reports/word/StocksCommitments.docx").getInputStream();
			ServletOutputStream out = response.getOutputStream();
			doc = (XWPFDocument) new XWPFDocument(stream);
			replacePOI(doc, "header", "Report on commitments leading up to " + day);
			List<Object[]> ll = warehouseStockDAO.warehouseStockCommitment(day);
			replaceDynamicTable(doc, ll);
			response.setHeader("Content-Disposition", "attachment; filename=\"StocksCommitments.doc\"");
			response.setContentType("application/vnd.ms-word");
			doc.write(out);
			baos.writeTo(out);
			out.flush();
	}

	//****************************************************************************************************************
	private static XWPFDocument replaceDynamicTable(XWPFDocument doc, List<Object[]> ll) throws NumberFormatException, Exception {
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

	//#*******************************************************************************************
	@Loggable
	@GetMapping(value = {"/print-export/{date}"})
	public void printExport(HttpServletResponse response, @PathVariable("date") String date)
			throws Exception {
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		InputStream stream;

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		dtf.format(PersianDate.now());

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFFont font = workbook.createFont();
			font.setFontName("B Nazanin");
			XWPFDocument doc;

			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			stream = new ClassPathResource("reports/word/exports.docx").getInputStream();
			ServletOutputStream out = response.getOutputStream();
			doc = (XWPFDocument) new XWPFDocument(stream);
			replacePOI(doc, "header", "خلاصه پرونده های صادراتی سال ");
			List<Object[]> ll = warehouseStockDAO.export(day);
			replaceDynamicTable1(doc, ll);
			response.setHeader("Content-Disposition", "attachment; filename=\"exports.doc\"");
			response.setContentType("application/vnd.ms-word");
			doc.write(out);
			baos.writeTo(out);
			out.flush();
	}

	//****************************************************************************************************************
	private static XWPFDocument replaceDynamicTable1(XWPFDocument doc, List<Object[]> ll) throws NumberFormatException, Exception {
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

}
