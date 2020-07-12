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
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-unit")
public class UnitFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String showUnit(HttpServletRequest request) throws JsonProcessingException {

        Map<String , String> categoryUnit = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) categoryUnit.put(value.name() , value.name());
        request.setAttribute("Enum_CategoryUnit" , objectMapper.writeValueAsString(categoryUnit) );

        Map<String , String > symbolUnit = new HashMap<>();
        for(SymbolUnit value :  SymbolUnit.values()) symbolUnit.put(value.name() , value.name());
        request.setAttribute("Enum_SymbolUnit" , objectMapper.writeValueAsString(symbolUnit));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_UNIT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_UNIT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_UNIT"));

        return "base/unit/unit";
    }
}
