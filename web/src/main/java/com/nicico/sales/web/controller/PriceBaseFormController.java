package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.utility.SecurityChecker;
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

        SecurityChecker.addEntityPermissionToRequest(request, PriceBase.class);

        return "priceBase/priceBase";
    }
}
