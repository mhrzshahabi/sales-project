package com.nicico.sales.web.controller.invoice.foreign;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItemDetail;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoicePayment;
import com.nicico.sales.model.enumeration.*;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/foreign-invoice")
public class ForeignInvoiceFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request,
                ForeignInvoice.class,
                ForeignInvoicePayment.class,
                ForeignInvoiceItem.class,
                ForeignInvoiceItemDetail.class);

        Map<String, String> rateReferences = new HashMap<>();
        for (RateReference value : RateReference.values()) rateReferences.put(value.name(), value.name());
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));

        Map<String, String> deductionTypes = new HashMap<>();
        for (DeductionType value : DeductionType.values()) deductionTypes.put(value.name(), value.name());
        request.setAttribute("Enum_DeductionType", objectMapper.writeValueAsString(deductionTypes));

        Map<String, String> currencyUnits = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) currencyUnits.put(value.name(), value.name());
        request.setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(currencyUnits));

        Map<String, String> commercialRoles = new HashMap<>();
        for (CommercialRole value : CommercialRole.values()) commercialRoles.put(value.name(), value.name());
        request.setAttribute("Enum_CommercialRole", objectMapper.writeValueAsString(commercialRoles));

        Map<String, String> mileStone = new HashMap<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values()) mileStone.put(value.name(), value.name());
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        return "invoice/foreign/foreign-invoice";
    }
}
