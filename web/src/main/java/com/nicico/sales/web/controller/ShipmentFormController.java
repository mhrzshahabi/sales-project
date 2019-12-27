package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
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
import java.io.IOException;
import java.io.InputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {
    private final IShipmentService shipmentService;

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

    @RequestMapping("/showForm")
    public String showShipment() {

        return "shipment/shipment";
    }

    @RequestMapping("/print/{shipmentId}")
    public void printDocx(HttpServletRequest request, HttpServletResponse response, @PathVariable String shipmentId) throws IOException {

        InputStream stream;

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        dtf.format(PersianDate.now());
        String dateday = PersianDate.now().format(dtf);

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFFont font = workbook.createFont();
        font.setFontName("B Nazanin");
        XWPFDocument doc;

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ShipmentDTO.Info

                shipment = shipmentService.get(Long.valueOf(shipmentId));
        String description = shipment.getMaterial().getDescl();
        String shiptype = shipment.getShipmentType();


        if (description.contains("cat")) {
            if (shiptype.contains("bulk")) {

                stream = new ClassPathResource("reports/word/Ship_Cat_bulk.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);
                replacePOI(doc, "vessel_name", shipment.getVesselName());
                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc, "contract_amount", shipment.getAmount().toString());
                replacePOI(doc, "unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc, "descp", shipment.getMaterial().getDescp());
                replacePOI(doc, "tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%");
                replacePOI(doc, "contract_no", shipment.getContract().getContractNo());

                String[] loa = shipment.getPortByLoading().getPort().split(",");
                replacePOI(doc, "loa", loa[0]);

                String[] port = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "port", " به مقصد " + port[1]);


                replacePOI(doc, "comp", " به مقصد بندر " + port[0] + " در کشور " + port[1]);
                replacePOI(doc, "barname", String.valueOf(shipment.getNumberOfBLs()));
                replacePOI(doc, "dateday", dateday);


                response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_bulk.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();
            } else if (shiptype.contains("container")) {

                stream = new ClassPathResource("reports/word/Ship_Cat_Container.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);

                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc, "contract_amount", shipment.getAmount().toString());
                replacePOI(doc, "unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc, "descp", shipment.getMaterial().getDescp());
                replacePOI(doc, "tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%");
                replacePOI(doc, "contract_no", shipment.getContract().getContractNo());


                List<String> inspector = shipmentService.inspector();
                for (int i = 0; i < inspector.size(); i++) {

                    replacePOI(doc, "inspector", inspector.get(i));
                }


                replacePOI(doc, "noContainer", String.valueOf(shipment.getNoContainer()));
                replacePOI(doc, "loa", shipment.getPortByLoading().getPort());

                String[] port = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "port", " به مقصد " + port[1]);


                String[] portw = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "comp", " به مقصد بندر " + port[0] + " در کشور " + port[1]);
                replacePOI(doc, "containerType", shipment.getContainerType());
                replacePOI(doc, "blNumbers", shipment.getBlNumbers());
                replacePOI(doc, "bookingno", "(Booking No." + shipment.getBookingCat() + ")");


                replacePOI(doc, "dateday", dateday);


                response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_Container.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();
            }
        }

        if (description.contains("Conc")) {
            if (shiptype.contains("bulk")) {

                stream = new ClassPathResource("reports/word/Copper_Concentrate_bulk.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);

                replacePOI(doc, "tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%");
                replacePOI(doc, "vessel_name", shipment.getVesselName());
                replacePOI(doc, "contract_amount", shipment.getAmount().toString());
                replacePOI(doc, "descp", shipment.getMaterial().getDescp());
                replacePOI(doc, "unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc, "contract_no", shipment.getContract().getContractNo());
                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc, "loa", shipment.getPortByLoading().getPort());
                replacePOI(doc, "company", shipment.getContact().getNameFA());


                String[] port = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "port", " به مقصد " + port[1]);


                String[] portw = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "comp", " به مقصد بندر " + port[0] + "در کشور " + port[1]);


                replacePOI(doc, "dateday", dateday);

                List<String> inspector = shipmentService.inspector();
                for (int i = 0; i < inspector.size(); i++) {

                    replacePOI(doc, "inspector", inspector.get(i));
                }

                response.setHeader("Content-Disposition", "attachment; filename=\"Copper_Concentrate_bulk.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();
            }

        }

        if (description.contains("Mol")) {
            if (shiptype.contains("container")) {


                stream = new ClassPathResource("reports/word/Molybdenum Oxide.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);

                replacePOI(doc, "dateday", dateday);


                replacePOI(doc, "contract_amount", shipment.getAmount().toString());
                replacePOI(doc, "unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc, "descp", shipment.getMaterial().getDescp());
                replacePOI(doc, "contract_no", shipment.getContract().getContractNo());
                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc, "tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%");
                replacePOI(doc, "containerType", shipment.getContainerType() + " فوت ");
                replacePOI(doc, "buyer", shipment.getContact().getNameEN());
                replacePOI(doc, "company", shipment.getContactByAgent().getNameEN());


                String[] portw = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "comp", "به مقصد بندر " + portw[0] + "در کشور " + portw[1]);


                String shipId = shipment.getContract().getId();
                List<String> lotnamelist = shipmentService.findLotname(shipId);
                List<String> bookingNo = shipmentService.findbooking(shipId);


                List<String> inspector = shipmentService.inspector();
                for (int i = 0; i < inspector.size(); i++) {

                    replacePOI(doc, "inspector", inspector.get(i));
                }


                if (lotnamelist.size() != 0 && bookingNo.size() != 0) {
                    for (int k = 0; k < lotnamelist.size(); k++) {
                        for (int m = 0; m < k; m++) {
                            replacePOI(doc, "lot", lotnamelist.get(k) + " & " + lotnamelist.get(m));

                        }
                    }
                    for (int j = 0; j < bookingNo.size(); j++) {
                        for (int u = 0; u < j; u++) {
                            replacePOI(doc, "booking", lotnamelist.get(1) + "->  " + bookingNo.get(j) + "    " + lotnamelist.get(0) + " -> " + bookingNo.get(u));
                        }

                    }

                }

                int sizelotnamelist = lotnamelist.size();
                replacePOI(doc, "ola", String.valueOf(sizelotnamelist));
                replacePOI(doc, "nocont", shipment.getNoContainer().toString());


                response.setHeader("Content-Disposition", "attachment; filename=\"Molybdenum Oxide.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();

            }
        }

    }
}
