package com.nicico.sales.web.controller;

import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
import lombok.RequiredArgsConstructor;
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
@RequestMapping("/shipment")
public class ShipmentFormController {
	    private final IShipmentService shipmentService;
	@RequestMapping("/showForm")
	public String showShipment() {
		DateUtil a;
		return "shipment/shipment";
	}

	@RequestMapping("/print/{shipmentId}")
    public void printDocx(HttpServletRequest request, HttpServletResponse response,@PathVariable String shipmentId) {

        try {
            XWPFDocument doc;
            InputStream is = new ClassPathResource("Shipment_Cat.docx").getInputStream();

            ServletOutputStream out = response.getOutputStream();
            doc = (XWPFDocument) new XWPFDocument(is);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ShipmentDTO.Info shipment = shipmentService.get(Long.valueOf(shipmentId));

//            replaceDynamicTable(doc,shipment);

            replacePOI(doc,"vessel_name", shipment.getVesselName());
            replacePOI(doc,"agent", shipment.getContactByAgent().getNameFA());
            replacePOI(doc,"contract_amount", shipment.getAmount().toString());
            replacePOI(doc,"unitNameFa", shipment.getMaterial().getUnit().getNameFA());
            replacePOI(doc,"descp", shipment.getMaterial().getDescp());
            replacePOI(doc,"tolorance", "-/+%5");
            replacePOI(doc,"contract_no", shipment.getContract().getContractNo().toString());

            response.setHeader("Content-Disposition", "attachment; filename=\"Test.doc\"");
            response.setContentType("application/vnd.ms-word");
            doc.write(out);
            baos.writeTo(out);
            // out.close();
            out.flush();


        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
    }
    //****************************************************************************************************************
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
