package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm-step")
public class IncotermStepFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_INCOTERM_STEP"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_INCOTERM_STEP"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_INCOTERM_STEP"));
        return "contract2/incoterm-step";
    }
}
