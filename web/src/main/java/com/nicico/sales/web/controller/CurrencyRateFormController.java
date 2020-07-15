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
import java.util.Arrays;
import java.util.EnumSet;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-currencyRate")
public class CurrencyRateFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showCurrencyRate(HttpServletRequest request) throws JsonProcessingException {

        EnumSet<SymbolUnit> currencySymbols = EnumSet.of(
                SymbolUnit.$,
                SymbolUnit.¢,
                SymbolUnit.£,
                SymbolUnit.¥,
                SymbolUnit.€,
                SymbolUnit.ریال);
        String currencyStr = objectMapper.writeValueAsString(
                currencySymbols.
                        stream().
                        collect(Collectors.toMap(SymbolUnit::name, SymbolUnit::name)));
        request.setAttribute("Enum_SymbolCUR", currencyStr);

        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(
                Arrays.stream(RateReference.values())
                        .collect(Collectors.toMap(RateReference::name, RateReference::name)))
        );

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CURRENCY_RATE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CURRENCY_RATE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CURRENCY_RATE"));

        return "base/currencyRate/currencyRate";
    }
}
