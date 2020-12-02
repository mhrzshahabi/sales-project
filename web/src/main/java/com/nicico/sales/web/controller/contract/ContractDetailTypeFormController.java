package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.model.enumeration.ContractDetailTypeReference;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.utility.SecurityChecker;
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
        Map<Integer, String> rateReferences = new HashMap<>();
        Map<Integer, String> priceBaseReferences = new HashMap<>();

        for (DataType value : DataType.values())
            dataTypes.put(value.name(), value.getNameFA());
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
        request.setAttribute("contractDetailTypeReferences", objectMapper.writeValueAsString(contractDetailTypeReferences));
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReferences));
        request.setAttribute("Enum_EContractDetailTypeCode", objectMapper.writeValueAsString(contractDetailTypeCodes));
        request.setAttribute("Enum_EContractDetailValueKey", objectMapper.writeValueAsString(contractDetailValueKeys));

        SecurityChecker.addEntityPermissionToRequest(request, ContractDetailType.class);

        return "contract/contract-detail-type";
    }
}
