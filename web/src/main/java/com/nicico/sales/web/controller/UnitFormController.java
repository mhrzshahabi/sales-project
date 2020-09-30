package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.SymbolUnit;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-unit")
public class UnitFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showUnit(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> symbolUnit = new HashMap<>();
        for (SymbolUnit value : SymbolUnit.values()) symbolUnit.put(value.name(), value.name());
        request.setAttribute("Enum_SymbolUnit", objectMapper.writeValueAsString(symbolUnit));


        Map<String, String> categoryUnit = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) categoryUnit.put(value.name(), value.name());
        request.setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(categoryUnit));

        SecurityChecker.addEntityPermissionToRequest(request, Unit.class);

        return "base/unit/unit";
    }
}
