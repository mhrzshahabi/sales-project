package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract2")
public class ContractFormController2 {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_CONTRACT2"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_CONTRACT2"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_CONTRACT2"));
        return "contract2/contract";
    }
}
