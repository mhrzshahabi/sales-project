package com.nicico.sales.web.controller.contract;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.model.enumeration.RateReference;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract")
public class ContractFormController {

    private final ObjectMapper objectMapper;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<Integer, String> rateReferences = new HashMap<>();
        Map<Integer, String> priceBaseReferences = new HashMap<>();
        for (RateReference value : RateReference.values())
            rateReferences.put(value.getId(), value.name());
        for (PriceBaseReference value : PriceBaseReference.values())
            priceBaseReferences.put(value.getId(), value.name());
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));
        request.setAttribute("Enum_PriceBaseReference", objectMapper.writeValueAsString(priceBaseReferences));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CONTRACT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CONTRACT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CONTRACT"));
        request.setAttribute("f_entity", SecurityUtil.hasAuthority("F_CONTRACT"));
        request.setAttribute("o_entity", SecurityUtil.hasAuthority("O_CONTRACT"));
        request.setAttribute("a_entity", SecurityUtil.hasAuthority("A_CONTRACT"));
        request.setAttribute("i_entity", SecurityUtil.hasAuthority("I_CONTRACT"));

        return "contract/contract";
    }
}
