package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-currencyRate")
public class CurrencyRateFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showCurrencyRate(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> symbolTU = new HashMap<>();
        for (SymbolUnit symbolunit : SymbolUnit.values()) symbolTU.put(symbolunit.name(), symbolunit.name());
        request.setAttribute("Enum_SymbolUnit", objectMapper.writeValueAsString(symbolTU));


        Map<String, String> rReference = new HashMap<>();
        for (RateReference reference : RateReference.values()) rReference.put(reference.name(), reference.name());
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rReference));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CURRENCY_RATE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CURRENCY_RATE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CURRENCY_RATE"));

        return "base/currencyRate/currencyRate";
    }
}
