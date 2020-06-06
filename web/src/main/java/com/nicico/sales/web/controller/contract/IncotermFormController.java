package com.nicico.sales.web.controller.contract;

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

        request.setAttribute("c_entity", true/*SecurityChecker.check("" +
                "hasAuthority('C_INCOTERM') AND " +
                "hasAuthority('C_INCOTERM_STEPS') AND " +
                "hasAuthority('C_INCOTERM_RULES') AND " +
                "hasAuthority('C_INCOTERM_FORMS')")*/);
        request.setAttribute("u_entity", true/*SecurityChecker.check("" +
                "hasAuthority('U_INCOTERM') AND " +
                "hasAuthority('U_INCOTERM_STEPS') AND " +
                "hasAuthority('U_INCOTERM_RULES') AND " +
                "hasAuthority('U_INCOTERM_FORMS')")*/);
        request.setAttribute("d_entity", true/*SecurityChecker.check("" +
                "hasAuthority('D_INCOTERM') AND " +
                "hasAuthority('D_INCOTERM_STEPS') AND " +
                "hasAuthority('D_INCOTERM_RULES') AND " +
                "hasAuthority('D_INCOTERM_FORMS') AND " +
                "hasAuthority('D_INCOTERM_DETAIL') AND " +
                "hasAuthority('D_INCOTERM_PARTIES')")*/);

        return "contract2/incoterm";
    }
}
