package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm")
public class IncotermFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_INCOTERM"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_INCOTERM"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_INCOTERM"));
        return "contract2/incoterm";
    }
}