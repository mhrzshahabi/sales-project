package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.RateReference;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/contract-detail-type")
public class ContractDetailTypeFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> dataTypes = new HashMap<>();
        Map<String, String> rateReferences = new HashMap<>();
        Map<String, String> priceBaseReferences = new HashMap<>();
        for (DataType value : DataType.values()) dataTypes.put(value.name(), value.name());
        for (RateReference value : RateReference.values()) rateReferences.put(value.name(), value.name());
        for (PriceBaseReference value : PriceBaseReference.values())
            priceBaseReferences.put(value.name(), value.name());
        request.setAttribute("Enum_DataType", objectMapper.writeValueAsString(dataTypes));
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReferences));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CONTRACT_DETAIL_TYPE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CONTRACT_DETAIL_TYPE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CONTRACT_DETAIL_TYPE"));
        return "contract2/contract-detail-type";
    }
}
