package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.mfathi91.time.PersianDate;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.iservice.IRemittanceService;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {

    private final Environment environment;
    private final ObjectMapper objectMapper;
    private final IShipmentService shipmentService;
    private final IRemittanceService remittanceService;
    private final IAssayInspectionService assayInspectionService;
    private final IWeightInspectionService weightInspectionService;

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
                Arrays.stream(CategoryUnit.values()).collect(Collectors.toMap(CategoryUnit::name, CategoryUnit::getId))));

        request.getSession().setAttribute("Enum_EContractDetailTypeCode", objectMapper.writeValueAsString(
                Arrays.stream(EContractDetailTypeCode.values()).collect(Collectors.toMap(EContractDetailTypeCode::name, EContractDetailTypeCode::getId))));

        request.getSession().setAttribute("Enum_EContractDetailValueKey", objectMapper.writeValueAsString(
                Arrays.stream(EContractDetailValueKey.values()).collect(Collectors.toMap(EContractDetailValueKey::name, EContractDetailValueKey::name))));

        SecurityChecker.addEntityPermissionToRequest(request, Shipment.class);

        return "shipment/shipment";
    }

    @RequestMapping("/print/{shipmentId}/{fileNewName}")
    public void printDocx(HttpServletResponse response, @PathVariable Long shipmentId, @PathVariable String fileNewName) throws IOException {

        ShipmentDTO.Info shipment = shipmentService.get(shipmentId);

        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        String filePath = UPLOAD_FILE_DIR + File.separator + "shipment" + File.separator + fileNewName;
        File downloadFile = new File(filePath);
        FileInputStream inputStream = new FileInputStream(downloadFile);

        ServletOutputStream out = response.getOutputStream();
        XWPFDocument doc = new XWPFDocument(inputStream);
        replacePOI(doc, "vessel_name", (shipment.getVessel() != null ? shipment.getVessel().getName() : ""));
        replacePOI(doc, "agent", shipment.getContactAgent().getNameFA());
        replacePOI(doc, "contract_amount", String.valueOf((shipment.getAmount() != null ? shipment.getAmount() : "")));
        replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
        replacePOI(doc, "descFA", (shipment.getMaterial() != null ? shipment.getMaterial().getDescFA() : ""));
        replacePOI(doc, "tolorance", "-/+" + (shipment.getContractShipment() != null ? shipment.getContractShipment().getTolorance().toString() : "") + "%");
        replacePOI(doc, "contract_no", (shipment.getContractShipment() != null ? shipment.getContractShipment().getContract().getNo() : ""));
        replacePOI(doc, "loa", (shipment.getContractShipment() != null && shipment.getContractShipment().getLoadPort() != null ? shipment.getContractShipment().getLoadPort().getLoa() : ""));

        String[] disPort = shipment.getDischargePort().getPort().split(",");
        replacePOI(doc, "dis", disPort[0]);

        replacePOI(doc, "country", (shipment.getDischargePort() != null ? shipment.getDischargePort().getCountry().getNameFa() : ""));
        replacePOI(doc, "barname", String.valueOf((shipment.getNoBLs() != null ? shipment.getNoBLs() : "")));

        List<ContactDTO.Info> inspectorContacts = assayInspectionService.getShipmentInspector(shipmentId);
        inspectorContacts.addAll(weightInspectionService.getShipmentInspector(shipmentId));
        List<String> inspectors = inspectorContacts.stream().map(ContactDTO::getNameEN).distinct().collect(Collectors.toList());
        if (inspectors.size() == 0)
            replacePOI(doc, "inspector", "نامشخص");
        else
            replacePOI(doc, "inspector", String.join(",", inspectors));

        replacePOI(doc, "noContainer", String.valueOf(shipment.getNoContainer() != null ? shipment.getNoContainer() : ""));
        replacePOI(doc, "containerType", shipment.getContainerType());
        replacePOI(doc, "blNumbers", String.valueOf(shipment.getNoBLs()));
        replacePOI(doc, "bookingno", "(Booking No." + (shipment.getBookingCat() != null ? shipment.getBookingCat() : "") + ")");
        replacePOI(doc, "dateday", DateUtil.todayDate());
        replacePOI(doc, "buyer", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
        replacePOI(doc, "company", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
        replacePOI(doc, "disPort", (shipment.getDischargePort() != null ? shipment.getDischargePort().getPort() : ""));
        replacePOI(doc, "month", String.valueOf(shipment.getSendDate().getMonth() + 1));
        replacePOI(doc, "year", (shipment.getContractShipment() != null ? shipment.getContractShipment().getSendDate().toString() : ""));
        replacePOI(doc, "nocont", String.valueOf(shipment.getNoContainer() != null ? shipment.getNoContainer() : ""));

        List<String> lots = remittanceService.getLotsByShipmentId(shipmentId);
        for (String s : lots)
            replacePOI(doc, "lots", s);

        replacePOI(doc, "ola", String.valueOf(lots.size()));

        DateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
        replacePOI(doc, "arrivalDateFrom", shipment.getArrivalDateFrom() != null ? dtf.format(shipment.getArrivalDateFrom()) : "");
        replacePOI(doc, "arrivalDateTo", shipment.getArrivalDateTo() != null ? dtf.format(shipment.getArrivalDateTo()) : "");
        replacePOI(doc, "letterDate", shipment.getLastDeliveryLetterDate() != null ? dtf.format(shipment.getLastDeliveryLetterDate()) : "");

        response.setHeader("Content-Disposition", "attachment; filename=" + fileNewName);
        response.setContentType("application/vnd.ms-word");
        doc.write(out);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        outputStream.writeTo(out);
        out.flush();
    }
}