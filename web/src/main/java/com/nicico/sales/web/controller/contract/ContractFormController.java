package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.iservice.contract.IContractService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTableValue;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.contract.ContractDetail;
import com.nicico.sales.model.entities.contract.ContractDetailValue;
import com.nicico.sales.model.enumeration.ContractDetailTypeReference;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.utility.StringFormatUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract")
public class ContractFormController {

    private final ObjectMapper objectMapper;
    private final IContractService contractService;

    @RequestMapping("/show-form/{contractType}")
    public String show(HttpServletRequest request, @PathVariable String contractType) throws JsonProcessingException {

        Map<Integer, String> rateReferences = new HashMap<>();
        Map<Integer, String> priceBaseReferences = new HashMap<>();
        for (RateReference value : RateReference.values())
            rateReferences.put(value.getId(), value.name());
        for (PriceBaseReference value : PriceBaseReference.values())
            priceBaseReferences.put(value.getId(), value.name());

        Map<String, String> contractDetailTypeCodes;
        Map<String, String> contractDetailValueKeys;
        Map<String, String> dataTypes = new HashMap<>();
        Map<String, String> dataTypesFa = new HashMap<>();
        Map<String, String> contractDetailTypeReferences = new HashMap<>();

        for (DataType value : DataType.values())
            dataTypes.put(value.name(), value.name());
        for (DataType value : DataType.values())
            dataTypesFa.put(value.name(), value.getNameFA());
        for (RateReference value : RateReference.values())
            rateReferences.put(value.getId(), value.name());
        for (PriceBaseReference value : PriceBaseReference.values())
            priceBaseReferences.put(value.getId(), value.name());
        for (ContractDetailTypeReference value : ContractDetailTypeReference.values())
            contractDetailTypeReferences.put(value.name(), value.name() + " ( " + value.getType() + " ) ");

        contractDetailTypeCodes = Arrays.stream(EContractDetailTypeCode.values()).collect(Collectors.toMap(EContractDetailTypeCode::name, EContractDetailTypeCode::getId, (e1, e2) -> e2))
                .entrySet().stream().sorted((Map.Entry.comparingByKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e2, LinkedHashMap::new));

        contractDetailValueKeys = Arrays.stream(EContractDetailValueKey.values()).collect(Collectors.toMap(EContractDetailValueKey::name, EContractDetailValueKey::getId, (e1, e2) -> e2))
                .entrySet().stream().sorted((Map.Entry.comparingByKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e2, LinkedHashMap::new));

        request.setAttribute("Enum_DataType", objectMapper.writeValueAsString(dataTypes));
        request.setAttribute("Enum_DataType_Fa", objectMapper.writeValueAsString(dataTypesFa));
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReferences));
        request.setAttribute("Enum_EContractDetailValueKey", objectMapper.writeValueAsString(contractDetailValueKeys));
        request.setAttribute("Enum_EContractDetailTypeCode", objectMapper.writeValueAsString(contractDetailTypeCodes));
        request.setAttribute("Enum_ContractDetailTypeReference", objectMapper.writeValueAsString(contractDetailTypeReferences));

        if (contractType.equalsIgnoreCase("CONTRACT"))
            request.setAttribute("Contract_Type_Id", 1);
        else if (contractType.equalsIgnoreCase("APPENDIX"))
            request.setAttribute("Contract_Type_Id", 2);
        else if (contractType.equalsIgnoreCase("TEMPLATE"))
            request.setAttribute("Contract_Type_Id", 3);


        if (SecurityUtil.isAdmin())
            SecurityChecker.addEntityPermissionToRequest(request, Contract.class);
        else {

            String contractClassName = Contract.class.getSimpleName();
            String contractPermissionKey = StringFormatUtil.makeMessageKey(contractClassName, "_").toUpperCase();

            String contractDetailClassName = ContractDetail.class.getSimpleName();
            String contractDetailPermissionKey = StringFormatUtil.makeMessageKey(contractDetailClassName, "_").toUpperCase();

            String contractDetailValueClassName = ContractDetailValue.class.getSimpleName();
            String contractDetailValuePermissionKey = StringFormatUtil.makeMessageKey(contractDetailValueClassName, "_").toUpperCase();

            String CDTPDynamicTableValueClassName = CDTPDynamicTableValue.class.getSimpleName();
            String CDTPDynamicTableValuePermissionKey = StringFormatUtil.makeMessageKey(CDTPDynamicTableValueClassName, "_").toUpperCase();

            String contractTemplatePermissionKey = contractType.equalsIgnoreCase("CONTRACT") ? "_TEMPLATE" : "";
            request.setAttribute("r_entity", SecurityUtil.hasAuthority("R_" + contractPermissionKey + contractTemplatePermissionKey));

            request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_" + contractPermissionKey + contractTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_" + contractPermissionKey + contractTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_" + contractPermissionKey + contractTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("f_entity", SecurityUtil.hasAuthority("F_" + contractPermissionKey));
            request.setAttribute("o_entity", SecurityUtil.hasAuthority("O_" + contractPermissionKey));
            request.setAttribute("a_entity", SecurityUtil.hasAuthority("A_" + contractPermissionKey));
            request.setAttribute("i_entity", SecurityUtil.hasAuthority("I_" + contractPermissionKey));
        }

        return "contract/contract";
    }

    @RequestMapping("/print/pdf/{id}")
    public void printPDF(HttpServletResponse response, @PathVariable Long id) throws IOException {
        response.setHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PDF.getSubtype());
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"contract.pdf\"");
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        StringBuffer content = new StringBuffer("<html><head><style> @page {margin-top: 1.7in;margin-bottom: 1.7in;}</style></head><body>");
        content.append(contractService.getContent(id));
        content.append("</body></html>");
        HtmlConverter.convertToPdf(content.toString(), writer);
    }
}
