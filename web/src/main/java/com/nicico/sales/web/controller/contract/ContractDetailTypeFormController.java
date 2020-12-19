package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;
import com.nicico.sales.model.enumeration.ContractDetailTypeReference;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.utility.StringFormatUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@RequestMapping("/contract-detail-type")
public class ContractDetailTypeFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> contractDetailTypeReferences = new HashMap<>();
        Map<String, String> contractDetailTypeCodes;
        Map<String, String> contractDetailValueKeys;
        Map<String, String> dataTypes = new HashMap<>();
        Map<String, String> dataTypesFa = new HashMap<>();
        Map<Integer, String> rateReferences = new HashMap<>();
        Map<Integer, String> priceBaseReferences = new HashMap<>();

        for (DataType value : DataType.values())
            dataTypes.put(value.name(), value.name());
        for (DataType value : DataType.values())
            dataTypesFa.put(value.name(), value.getNameFA());
        for (ContractDetailTypeReference value : ContractDetailTypeReference.values())
            contractDetailTypeReferences.put(value.name(), value.name() + " ( " + value.getType() + " ) ");
        for (RateReference value : RateReference.values())
            rateReferences.put(value.getId(), value.name());
        for (PriceBaseReference value : PriceBaseReference.values())
            priceBaseReferences.put(value.getId(), value.name());

        contractDetailTypeCodes = Arrays.stream(EContractDetailTypeCode.values()).collect(Collectors.toMap(EContractDetailTypeCode::name, EContractDetailTypeCode::getId, (e1, e2) -> e2))
                .entrySet().stream().sorted((Map.Entry.comparingByKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e2, LinkedHashMap::new));

        contractDetailValueKeys = Arrays.stream(EContractDetailValueKey.values()).collect(Collectors.toMap(EContractDetailValueKey::name, EContractDetailValueKey::getId, (e1, e2) -> e2))
                .entrySet().stream().sorted((Map.Entry.comparingByKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e2, LinkedHashMap::new));

        request.setAttribute("Enum_DataType", objectMapper.writeValueAsString(dataTypes));
        request.setAttribute("Enum_DataType_Fa", objectMapper.writeValueAsString(dataTypesFa));
        request.setAttribute("Enum_ContractDetailTypeReference", objectMapper.writeValueAsString(contractDetailTypeReferences));
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReferences));
        request.setAttribute("Enum_EContractDetailTypeCode", objectMapper.writeValueAsString(contractDetailTypeCodes));
        request.setAttribute("Enum_EContractDetailValueKey", objectMapper.writeValueAsString(contractDetailValueKeys));

        if (SecurityUtil.isAdmin())
            SecurityChecker.addEntityPermissionToRequest(request, ContractDetailType.class);
        else {

            String contractDetailTypeClassName = ContractDetailType.class.getSimpleName();
            String contractDetailTypePermissionKey = StringFormatUtil.makeMessageKey(contractDetailTypeClassName, "_").toUpperCase();

            String contractDetailTypeParamClassName = ContractDetailTypeParam.class.getSimpleName();
            String contractDetailTypeParamPermissionKey = StringFormatUtil.makeMessageKey(contractDetailTypeParamClassName, "_").toUpperCase();

            String contractDetailTypeTemplateClassName = ContractDetailTypeTemplate.class.getSimpleName();
            String contractDetailTypeTemplatePermissionKey = StringFormatUtil.makeMessageKey(contractDetailTypeTemplateClassName, "_").toUpperCase();

            String CDTPDynamicTableClassName = CDTPDynamicTable.class.getSimpleName();
            String CDTPDynamicTablePermissionKey = StringFormatUtil.makeMessageKey(CDTPDynamicTableClassName, "_").toUpperCase();

            request.setAttribute("r_entity", SecurityUtil.hasAuthority("R_" + contractDetailTypePermissionKey));

            request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_" + contractDetailTypePermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + contractDetailTypeParamPermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + contractDetailTypeTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("C_" + CDTPDynamicTablePermissionKey));

            request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_" + contractDetailTypePermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + contractDetailTypeParamPermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + contractDetailTypeTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("U_" + CDTPDynamicTablePermissionKey));

            request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_" + contractDetailTypePermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + contractDetailTypeParamPermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + contractDetailTypeTemplatePermissionKey) &&
                    SecurityUtil.hasAuthority("D_" + CDTPDynamicTablePermissionKey));

            request.setAttribute("f_entity", SecurityUtil.hasAuthority("F_" + contractDetailTypePermissionKey));
            request.setAttribute("o_entity", SecurityUtil.hasAuthority("O_" + contractDetailTypePermissionKey));
            request.setAttribute("a_entity", SecurityUtil.hasAuthority("A_" + contractDetailTypePermissionKey));
            request.setAttribute("i_entity", SecurityUtil.hasAuthority("I_" + contractDetailTypePermissionKey));
        }

        return "contract/contract-detail-type";
    }
}
