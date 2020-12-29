package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.iservice.IRemittanceService;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.service.FileService;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.web.controller.utility.WordUtil;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {

    private final WordUtil wordUtil;
    private final Environment environment;
    private final ObjectMapper objectMapper;
    private final IShipmentService shipmentService;
    private final IRemittanceService remittanceService;
    private final IAssayInspectionService assayInspectionService;
    private final IWeightInspectionService weightInspectionService;
    private final FileService fileService;

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

    @RequestMapping("/print/{shipmentId}/{fileKey}")
    public void printDocx(HttpServletResponse response, @PathVariable Long shipmentId, @PathVariable String fileKey) throws IOException {

        ShipmentDTO.Info shipment = shipmentService.get(shipmentId);
        FileDTO.Response retrieve = fileService.retrieve(fileKey);
        ByteArrayInputStream inputStream = new ByteArrayInputStream(retrieve.getContent());
        ServletOutputStream out = response.getOutputStream();
        XWPFDocument doc = new XWPFDocument(inputStream);
        wordUtil.replacePOI(doc, "vessel_name", (shipment.getVessel() != null ? shipment.getVessel().getName() : ""));
        wordUtil.replacePOI(doc, "agent", shipment.getContactAgent().getNameFA());
        wordUtil.replacePOI(doc, "contract_amount", String.valueOf((shipment.getAmount() != null ? shipment.getAmount() : "")));
        wordUtil.replacePOI(doc, "unitNameFa", (shipment.getUnit() != null ? shipment.getUnit().getNameFA() : ""));
        wordUtil.replacePOI(doc, "descFA", (shipment.getMaterial() != null ? shipment.getMaterial().getDescFA() : ""));
        wordUtil.replacePOI(doc, "tolerance", "-/+" + (shipment.getContractShipment() != null ? shipment.getContractShipment().getTolerance().toString() : "") + "%");
        wordUtil.replacePOI(doc, "contract_no", (shipment.getContractShipment() != null ? shipment.getContractShipment().getContract().getNo() : ""));
        wordUtil.replacePOI(doc, "loa", (shipment.getContractShipment() != null && shipment.getContractShipment().getLoadPort() != null ? shipment.getContractShipment().getLoadPort().getLoa() : ""));

        String[] disPort = shipment.getDischargePort().getPort().split(",");
        wordUtil.replacePOI(doc, "dis", disPort[0]);

        wordUtil.replacePOI(doc, "country", (shipment.getDischargePort() != null ? shipment.getDischargePort().getCountry().getNameFA() : ""));
        wordUtil.replacePOI(doc, "barname", String.valueOf((shipment.getNoBLs() != null ? shipment.getNoBLs() : "")));

        List<ContactDTO.Info> inspectorContacts = assayInspectionService.getShipmentInspector(shipmentId);
        inspectorContacts.addAll(weightInspectionService.getShipmentInspector(shipmentId));
        List<String> inspectors = inspectorContacts.stream().map(ContactDTO::getNameEN).distinct().collect(Collectors.toList());
        if (inspectors.size() == 0)
            wordUtil.replacePOI(doc, "inspector", "نامشخص");
        else
            wordUtil.replacePOI(doc, "inspector", String.join(",", inspectors));

        wordUtil.replacePOI(doc, "noContainer", String.valueOf(shipment.getNoContainer() != null ? shipment.getNoContainer() : ""));
        wordUtil.replacePOI(doc, "containerType", shipment.getContainerType());
        wordUtil.replacePOI(doc, "blNumbers", String.valueOf(shipment.getNoBLs()));
        wordUtil.replacePOI(doc, "bookingno", "(Booking No." + (shipment.getBookingCat() != null ? shipment.getBookingCat() : "") + ")");
        wordUtil.replacePOI(doc, "dateday", DateUtil.todayDate());
        wordUtil.replacePOI(doc, "buyer", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
        wordUtil.replacePOI(doc, "company", (shipment.getContact() != null ? shipment.getContact().getNameFA() : ""));
        wordUtil.replacePOI(doc, "disPort", (shipment.getDischargePort() != null ? shipment.getDischargePort().getPort() : ""));
        wordUtil.replacePOI(doc, "month", String.valueOf(shipment.getSendDate().getMonth() + 1));
        wordUtil.replacePOI(doc, "year", (shipment.getContractShipment() != null ? shipment.getContractShipment().getSendDate().toString() : ""));
        wordUtil.replacePOI(doc, "nocont", String.valueOf(shipment.getNoContainer() != null ? shipment.getNoContainer() : ""));

        List<String> lots = remittanceService.getLotsByShipmentId(shipmentId);
        for (String s : lots)
            wordUtil.replacePOI(doc, "lots", s);

        wordUtil.replacePOI(doc, "ola", String.valueOf(lots.size()));

        DateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
        wordUtil.replacePOI(doc, "arrivalDateFrom", shipment.getArrivalDateFrom() != null ? dtf.format(shipment.getArrivalDateFrom()) : "");
        wordUtil.replacePOI(doc, "arrivalDateTo", shipment.getArrivalDateTo() != null ? dtf.format(shipment.getArrivalDateTo()) : "");
        wordUtil.replacePOI(doc, "letterDate", shipment.getLastDeliveryLetterDate() != null ? dtf.format(shipment.getLastDeliveryLetterDate()) : "");

        response.setHeader("Content-Disposition", retrieve.getContentDisposition().toString());
        response.setContentType("application/vnd.ms-word");
        doc.write(out);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        outputStream.writeTo(out);
        out.flush();
    }
}