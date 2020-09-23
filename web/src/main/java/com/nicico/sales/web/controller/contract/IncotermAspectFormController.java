package com.nicico.sales.web.controller.contract;

import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm-aspect")
public class IncotermAspectFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, IncotermAspect.class);

        return "contract/incoterm-aspect";
    }
}
