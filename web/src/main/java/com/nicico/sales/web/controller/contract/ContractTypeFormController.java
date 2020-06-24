package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract-type")
public class ContractTypeFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CONTRACT_TYPE"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CONTRACT_TYPE"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CONTRACT_TYPE"));
        return "contract2/contract-type";
    }
}
