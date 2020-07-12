package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.SymbolCurrency;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-currency")
public class CurrencyFormController {


    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showCurrency(HttpServletRequest request) throws JsonProcessingException {

        Map<String , String> symbolCurrency = new HashMap<>();
        for (SymbolCurrency value : SymbolCurrency.values()) symbolCurrency.put(value.name() , value.name());
        request.setAttribute("Enum_SymbolCurrency" , objectMapper.writeValueAsString(symbolCurrency) );


        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CURRENCY"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CURRENCY"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CURRENCY"));


        return "base/currency/currency";
    }
}
