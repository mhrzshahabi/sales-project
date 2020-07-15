package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-unit")
public class UnitFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showUnit(HttpServletRequest request) throws JsonProcessingException {

        request.setAttribute("Enum_SymbolUnit_WithValue", objectMapper.writeValueAsString(
                Arrays.stream(SymbolUnit.values()).
                        collect(Collectors.
                                toMap(SymbolUnit::name, SymbolUnit::name)))
        );

        Map<String, String> categoryUnit = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) categoryUnit.put(value.name(), value.name());
        request.setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(categoryUnit));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_UNIT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_UNIT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_UNIT"));

        return "base/unit/unit";
    }
}
