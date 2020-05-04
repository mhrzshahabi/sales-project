package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.DataType;
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

        Map<Integer, String> dataTypes = new HashMap<>();
        for (DataType value : DataType.values()) dataTypes.put(value.getId(), value.name());
        request.setAttribute("Enum_DataType", objectMapper.writeValueAsString(dataTypes));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CONTRACT_DETAIL_TYPE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CONTRACT_DETAIL_TYPE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CONTRACT_DETAIL_TYPE"));
        return "contract2/contract-detail-type";
    }
}
