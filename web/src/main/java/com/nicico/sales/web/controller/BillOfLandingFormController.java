package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/bill-of-landing")
public class BillOfLandingFormController {

    private final ObjectMapper objectMapper;

    @GetMapping(value = "show-form")
    public String showHomePage(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request, BillOfLanding.class);
        Map<String, String> categoryUnit = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) categoryUnit.put(value.name(), value.name());
        request.setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(categoryUnit));

        return "contract/bill-of-landing";
    }
}
