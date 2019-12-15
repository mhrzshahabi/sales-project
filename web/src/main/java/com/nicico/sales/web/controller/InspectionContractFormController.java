package com.nicico.sales.web.controller;


import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.service.InspectionContractService;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.List;


@RequiredArgsConstructor
@Controller
@RequestMapping("/inspectionContract")
public class InspectionContractFormController {


	/*Create REF From Shipment & Inspection Get necessary show in form */
	private final InspectionContractService inspectionContractService;
	ShipmentDTO.Info shipment ;


	/*return Page inspectionContract.jsp*/
	@RequestMapping("/showForm")
	public String showInspectionContract() {
		return "shipment/inspectionContract";
	}


	/*get Data from smartClient by Rest */
	@RequestMapping("/print/{inspectionByContactId}")
	public void printInspectionContract(HttpServletRequest request , HttpServletResponse response , @PathVariable Long inspectionByContactId) throws Exception {

		/*Set Initializer*/
		InputStream stream ;


		/*Start Running Code With Exception*/ //TODO
		try {
			/*Apache POI*/
			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFFont font = workbook.createFont();
			font.setFontName("B Nazanin");
			XWPFDocument doc;
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			InspectionContractDTO.Info inspection = inspectionContractService.get(Long.valueOf(inspectionByContactId));



			/*Get Doc File From main\resources\Inspection_Contract*/
			stream = new ClassPathResource("reports/word/Inspection_Contract.docx").getInputStream();
			ServletOutputStream out = response.getOutputStream();
			doc = (XWPFDocument) new XWPFDocument(stream);


			/*Set on the Word */
			String material = inspectionContractService.getMaterial(inspectionByContactId);
			replacePOI(doc,"descp",  material);

			String[] showdate = inspection.getCreateDate().split("T");
			replacePOI(doc,"date", showdate[0] );


			String ves = inspectionContractService.ves(inspectionByContactId);
			replacePOI(doc,"ves",  ves);


			String amount = inspectionContractService.amount(inspectionByContactId);
			replacePOI(doc, "amount" , amount);


			String port = inspectionContractService.port(inspectionByContactId);
			replacePOI(doc, "port" , port);


			String loading = inspectionContractService.loading(inspectionByContactId);
			replacePOI(doc, "loading" , loading);


			String buyer = inspectionContractService.buyer(inspectionByContactId);
			replacePOI(doc, "buyer" , buyer);

			String contractNo = inspectionContractService.contractNo(inspectionByContactId);
			replacePOI(doc, "contractNo" , contractNo);


			List<String> eB = inspectionContractService.email(inspectionByContactId);
			List<String>  eS =  inspectionContractService.emailSel();

			String temp = "";
			for (int i = 0 ; i < eB.size() ; i++){

				for(String s: eB.get(i).split(","))
					temp = temp.concat(s).concat(",");
			}
			replacePOI(doc, "rezaa" ,  temp );

/*************************************************************************************/
			String tempS = "";
			for (int i = 0 ; i < eS.size() ; i++){

				for(String s: eS.get(i).split(","))
					tempS = tempS.concat(s).concat(",");
			}
			replacePOI(doc, "rezat" ,  tempS );
			/*Create doc from Inspection_Contract & Shipment*/
			response.setHeader("Content-Disposition", "attachment; filename=\"Inspection_Contract.doc\"");
			response.setContentType("application/vnd.ms-word");
			doc.write(out);
			outputStream.writeTo(out);
			out.flush();

		}catch (Exception ex){
			ex.printStackTrace();
		}
	}





	/*-------------------------------------------------------------------*/
	private static XWPFDocument replaceDynamicTable(XWPFDocument doc,ShipmentDTO.Info shipment) throws NumberFormatException, Exception {
		List<XWPFTable> tables = doc.getTables();
		XWPFTable table = tables.get(1);
		for (int r = 0; r < 1; r++) {
			XWPFTableRow tablerow1 = table.createRow();
			List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
			XWPFParagraph para3 = tableCells1.get(0).getParagraphs().get(0);
			XWPFRun rh3 = para3.createRun();
			rh3.setText(r + "");
			para3 = tableCells1.get(1).getParagraphs().get(0);
			rh3 = para3.createRun();
			rh3.setFontSize(8);
			if (shipment.getContactByAgent() != null)
				rh3.setText(shipment.getContactByAgent().getNameEN().toString());
			else
				rh3.setText("");
		}
		return doc;
	}


	public static XWPFDocument replacePOI(XWPFDocument doc, String placeHolder, String replaceText){
		// REPLACE ALL HEADERS
		for (XWPFHeader header : doc.getHeaderList())
			replaceAllBodyElements(header.getBodyElements(), placeHolder, replaceText);
		// REPLACE BODY
		replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
		return doc;
	}

	private static void replaceAllBodyElements(List<IBodyElement> bodyElements, String placeHolder, String replaceText){
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


}
