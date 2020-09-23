package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.base.CurrencyRate;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-currencyRate")
public class CurrencyRateFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showCurrencyRate(HttpServletRequest request) throws JsonProcessingException {


        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(
                Arrays.stream(RateReference.values())
                        .collect(Collectors.toMap(RateReference::name, RateReference::name)))
        );

        SecurityChecker.addEntityPermissionToRequest(request, CurrencyRate.class);

        return "base/currencyRate/currencyRate";
    }
}
