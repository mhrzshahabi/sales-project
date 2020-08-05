package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.WeighingType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/price-base")
public class PriceBaseFormController {

    private final ObjectMapper objectMapper;


    @RequestMapping("/showForm")
    public String show(HttpServletRequest request) throws JsonProcessingException {


        Map<String, String> priceBaseReference = new HashMap<>();
        for (PriceBaseReference value : PriceBaseReference.values()) priceBaseReference.put(value.name(), value.name());
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReference));


        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_PRICE_BASE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_PRICE_BASE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_PRICE_BASE"));

        return "priceBase/priceBase";
    }
}
