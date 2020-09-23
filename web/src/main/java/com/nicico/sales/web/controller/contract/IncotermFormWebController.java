package com.nicico.sales.web.controller.contract;

import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.entities.contract.Incoterm;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm-form")
public class IncotermFormWebController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Incoterm.class);

        return "contract/incoterm-form";
    }
}
