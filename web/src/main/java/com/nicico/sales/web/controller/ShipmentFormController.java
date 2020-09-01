package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.mfathi91.time.PersianDate;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.enumeration.CategoryUnit;
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
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {
    private final IShipmentService shipmentService;
    private final ObjectMapper objectMapper;

    private void replacePOI(XWPFDocument doc, String placeHolder, String replaceText) {
        // REPLACE ALL HEADERS
        for (XWPFHeader header : doc.getHeaderList())
            replaceAllBodyElements(header.getBodyElements(), placeHolder, replaceText);
        // REPLACE BODY
        replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
    }

    private void replaceAllBodyElements(List<IBodyElement> bodyElements, String placeHolder, String replaceText) {
        for (IBodyElement bodyElement : bodyElements) {
            if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0)
                replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
            if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0)
                replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
        }
    }

    private void replaceTable(XWPFTable table, String placeHolder, String replaceText) {
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

    private void replaceParagraph(XWPFParagraph paragraph, String placeHolder, String replaceText) {
        for (XWPFRun r : paragraph.getRuns()) {
            String text = r.getText(r.getTextPosition());
            if (text != null && text.contains(placeHolder)) {
                text = text.replace(placeHolder, (replaceText != null ? replaceText : ""));
                r.setText(text, 0);
            }
        }
    }

    @RequestMapping("/showForm")
    public String showShipment(HttpServletRequest request) throws JsonProcessingException {
        request.getSession().setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(
                Arrays.stream(CategoryUnit.values()).collect(Collectors.toMap(CategoryUnit::name, CategoryUnit::getId)))
        );
        return "shipment/shipment";
    }

    @RequestMapping("/print/{shipmentId}")
    public void printDocx(HttpServletRequest request, HttpServletResponse response, @PathVariable Long shipmentId) throws IOException {

        //        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        //        String today = PersianDate.now().format(dtf);

        //        XSSFWorkbook workbook = new XSSFWorkbook();
        //        XSSFFont font = workbook.createFont();
        //        font.setFontName("B Nazanin");

        //        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        ShipmentDTO.Info shipment = shipmentService.get(shipmentId);
        //        String description = shipment.getMaterial().getDescl();
        //        String shiptype = shipment.getShipmentType();

        if (shipment.getMaterialId() == 2L) {
            if (shipment.getShipmentTypeId() == 1L) {

//                String fileName = String.format("reports/word/ShipOrder_%d_%d.docx", shipment.getMaterialId(), shipment.getShipmentTypeId());
//                ClassPathResource resource = new ClassPathResource(fileName);
//                if (!resource.exists())
//                    throw new SalesException2(new FileNotFoundException(""));
                //"reports/word/Ship_Cat_bulk.docx"
                InputStream inputStream = new ClassPathResource("reports/word/Ship_Cat_bulk.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                XWPFDocument doc = new XWPFDocument(inputStream);
                replacePOI(doc, "vessel_name", (shipment.getVessel() != null ? shipment.getVessel().getName() : ""));
                replacePOI(doc, "agent", shipment.getContactAgent().getNameFA());
                replacePOI(doc, "contract_amount", String.valueOf((shipment.getAmount() != null ? shipment.getAmount() : "")));
                replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
                replacePOI(doc, "descp", (shipment.getMaterial() != null ? shipment.getMaterial().getDescp() : ""));
                replacePOI(doc, "tolorance", "-/+" + (shipment.getContractShipment() != null ? shipment.getContractShipment().getTolorance().toString() : "") + "%");
                replacePOI(doc, "contract_no", (shipment.getContractShipment() != null ? shipment.getContractShipment().getContract().getNo() : ""));

                String[] loa = shipment.getContractShipment().getLoadPort().getPort().split(",");
                replacePOI(doc, "loa", loa[0]);

                String[] disPort = shipment.getDischargePort().getPort().split(",");
                replacePOI(doc, "dis", disPort[0]);

                replacePOI(doc, "country", (shipment.getDischargePort() != null ? shipment.getDischargePort().getCountry().getNameFa() : ""));
                replacePOI(doc, "barname", String.valueOf((shipment.getNoBLs() != null ? shipment.getNoBLs() : "")));
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                String today = PersianDate.now().format(dtf);
                replacePOI(doc, "dateday", today);


                response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_bulk.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                outputStream.writeTo(out);
                out.flush();
            } else if (shipment.getShipmentTypeId() == 2L) {
                String fileName = String.format("reports/word/ShipOrder_%d_%d.docx", shipment.getMaterialId(), shipment.getShipmentTypeId());
                //"reports/word/Ship_Cat_Container.docx"
                InputStream inputStream = new ClassPathResource(fileName).getInputStream();
                ServletOutputStream out = response.getOutputStream();
                XWPFDocument doc = new XWPFDocument(inputStream);

                replacePOI(doc, "agent", (shipment.getContactAgent() != null ? shipment.getContactAgent().getNameFA() : ""));
                replacePOI(doc, "contract_amount", (shipment.getAmount() != null ? shipment.getAmount().toString() : ""));
                replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
                replacePOI(doc, "descp", shipment.getMaterial().getDescp());
                replacePOI(doc, "tolorance", "-/+" + (shipment.getContractShipment() != null ? shipment.getContractShipment().getTolorance().toString() : "") + "%");
                replacePOI(doc, "contract_no", (shipment.getContractShipment() != null ? shipment.getContractShipment().getContract().getNo() : ""));

                List<String> inspector = shipmentService.inspector();
                for (int i = 0; i < inspector.size(); i++) {

                    replacePOI(doc, "inspector", inspector.get(i));
                }

                replacePOI(doc, "noContainer", String.valueOf(shipment.getNoContainer() != null ? shipment.getNoContainer() : ""));
                //  replacePOI(doc, "loa", shipment.getPortByLoading().getPort());
                replacePOI(doc, "loa", (shipment.getContractShipment().getLoadPort().getLoa() != null ? shipment.getContractShipment().getLoadPort().getLoa() : ""));
                //  replacePOI(doc, "dis", shipment.getPortByDischarge().getPort());
                replacePOI(doc, "dis", shipment.getContractShipment().getLoadPort().getPort());
                //  replacePOI(doc, "country", shipment.getPortByDischarge().getCountry().getNameFa());
                replacePOI(doc, "country", shipment.getDischargePort().getCountry().getNameFa());
                replacePOI(doc, "containerType", shipment.getContainerType() == null ? "50" : shipment.getContainerType());
                //  replacePOI(doc, "blNumbers", shipment.getBlNumbers());
                replacePOI(doc, "blNumbers", String.valueOf(shipment.getNoBLs()));
                replacePOI(doc, "bookingno", "(Booking No." + shipment.getBookingCat() + ")");
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                String today = PersianDate.now().format(dtf);
                replacePOI(doc, "dateday", today);

                response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_Container.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                outputStream.writeTo(out);
                out.flush();
            }
        }

        if (shipment.getMaterialId() == 3L) {
            if (shipment.getShipmentTypeId() == 1L) {

                InputStream inputStream = new ClassPathResource("reports/word/Copper_Concentrate_bulk.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                XWPFDocument doc = new XWPFDocument(inputStream);

                replacePOI(doc, "tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%");
                replacePOI(doc, "vessel_name", (shipment.getVessel() != null ? shipment.getVessel().getName() : ""));
                replacePOI(doc, "contract_amount", (shipment.getAmount() != null ? shipment.getAmount().toString() : ""));
                replacePOI(doc, "descp", (shipment.getMaterial() != null ? shipment.getMaterial().getDescp() : ""));
                replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
                replacePOI(doc, "contract_no", shipment.getContractShipment().getContract().getNo());
                replacePOI(doc, "buyer", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
                replacePOI(doc, "agent", (shipment.getContactAgent() != null ? shipment.getContactAgent().getNameFA() : ""));
                // replacePOI(doc, "loa", shipment.getPortByLoading().getPort());
                replacePOI(doc, "loa", (shipment.getContractShipment() != null && shipment.getContractShipment().getLoadPort() != null ? shipment.getContractShipment().getLoadPort().getLoa() : ""));
                replacePOI(doc, "company", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
                //  replacePOI(doc, "country", shipment.getPortByDischarge().getCountry().getNameFa());
                replacePOI(doc, "country", (shipment.getDischargePort() != null && shipment.getDischargePort().getCountry() != null ? shipment.getDischargePort().getCountry().getNameFa() : ""));
                //  replacePOI(doc, "disPort", shipment.getPortByDischarge().getPort());
                replacePOI(doc, "disPort", (shipment.getDischargePort() != null ? shipment.getDischargePort().getPort() : ""));

                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                String today = PersianDate.now().format(dtf);
                replacePOI(doc, "dateday", today);
                List<String> inspector = shipmentService.inspector();
                for (String s : inspector) {

                    replacePOI(doc, "inspector", s);
                }
                response.setHeader("Content-Disposition", "attachment; filename=\"Copper_Concentrate_bulk.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                outputStream.writeTo(out);
                out.flush();
            }
        }

        if (shipment.getMaterialId() == 1L) {
            if (shipment.getShipmentTypeId() == 2L) {

                InputStream inputStream = new ClassPathResource("reports/word/Molybdenum Oxide.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                XWPFDocument doc = new XWPFDocument(inputStream);

                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                String today = PersianDate.now().format(dtf);
                replacePOI(doc, "dateday", today);

                replacePOI(doc, "contract_amount", String.valueOf(shipment.getAmount()));
                replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
                replacePOI(doc, "descp", (shipment.getMaterial() != null ? shipment.getMaterial().getDescp() : ""));
                //replacePOI(doc, "month", shipment.getMonth());
                replacePOI(doc, "month", String.valueOf(shipment.getSendDate().getMonth()));
                replacePOI(doc, "year", (shipment.getContractShipment() != null ? shipment.getContractShipment().getSendDate().toString() : ""));
                replacePOI(doc, "contract_no", (shipment.getContractShipment() != null ? shipment.getContractShipment().getContract().getNo() : ""));
                replacePOI(doc, "agent", (shipment.getContactAgent() != null ? shipment.getContactAgent().getNameFA() : ""));
                replacePOI(doc, "tolorance", "-/+" + (shipment.getContractShipment() != null ? shipment.getContractShipment().getTolorance().toString() : "") + "%");
                replacePOI(doc, "containertype", shipment.getContainerType());
                replacePOI(doc, "buyer", (shipment.getContact() != null ? shipment.getContact().getNameEN() : ""));
                //  replacePOI(doc, "disport", shipment.getPortByDischarge().getPort());
                replacePOI(doc, "disport", (shipment.getDischargePort() != null ? shipment.getDischargePort().getPort() : ""));
                //   replacePOI(doc, "country", shipment.getPortByDischarge().getCountry().getNameFa());
                replacePOI(doc, "country", (shipment.getDischargePort() != null && shipment.getDischargePort().getCountry() != null ? shipment.getDischargePort().getCountry().getNameFa() : ""));

                List<String> inspector = shipmentService.inspector();
                for (String s : inspector) {

                    replacePOI(doc, "inspector", s);
                }
                replacePOI(doc, "nocont", (shipment.getNoContainer() != null ? shipment.getNoContainer().toString() : ""));

                response.setHeader("Content-Disposition", "attachment; filename=\"Molybdenum Oxide.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                outputStream.writeTo(out);
                out.flush();

            }
        }

    }
}
