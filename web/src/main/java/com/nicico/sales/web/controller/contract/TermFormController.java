package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/term")
public class TermFormController {

    @RequestMapping("/showForm")
    public String showTerm(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_TERM"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_TERM"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_TERM"));
        return "contract2/term";
    }
}
