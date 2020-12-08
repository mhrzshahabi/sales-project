package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

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

            request.setAttribute("r_entity", SecurityUtil.hasAuthority("R" + contractPermissionKey));

            request.setAttribute("c_entity", SecurityUtil.hasAuthority("C" + contractPermissionKey) &&
                    SecurityUtil.hasAuthority("C" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("C" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("C" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("u_entity", SecurityUtil.hasAuthority("U" + contractPermissionKey) &&
                    SecurityUtil.hasAuthority("U" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("U" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("U" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("d_entity", SecurityUtil.hasAuthority("D" + contractPermissionKey) &&
                    SecurityUtil.hasAuthority("D" + contractDetailPermissionKey) &&
                    SecurityUtil.hasAuthority("D" + contractDetailValuePermissionKey) &&
                    SecurityUtil.hasAuthority("D" + CDTPDynamicTableValuePermissionKey));

            request.setAttribute("f_entity", SecurityUtil.hasAuthority("F" + contractPermissionKey));
            request.setAttribute("o_entity", SecurityUtil.hasAuthority("O" + contractPermissionKey));
            request.setAttribute("a_entity", SecurityUtil.hasAuthority("A" + contractPermissionKey));
            request.setAttribute("i_entity", SecurityUtil.hasAuthority("I" + contractPermissionKey));
        }

        return "contract/contract";
    }
}
