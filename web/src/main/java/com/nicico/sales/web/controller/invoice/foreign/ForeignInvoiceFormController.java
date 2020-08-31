package com.nicico.sales.web.controller.invoice.foreign;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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

        request.setAttribute("c_entity", SecurityChecker.check("" +
                "hasAuthority('C_FOREIGN_INVOICE') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_PAYMENT')"));
        request.setAttribute("u_entity", SecurityChecker.check("" +
                "hasAuthority('U_FOREIGN_INVOICE') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_PAYMENT')"));
        request.setAttribute("d_entity", SecurityChecker.check("" +
                "hasAuthority('D_FOREIGN_INVOICE') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_PAYMENT')"));

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

        Map<Integer, String> mileStone = new HashMap<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values()) mileStone.put(value.getId(), value.name());
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        return "invoice/foreign/foreign-invoice";
    }
}
