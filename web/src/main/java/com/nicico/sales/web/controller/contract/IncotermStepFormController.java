package com.nicico.sales.web.controller.contract;

import com.nicico.sales.model.entities.contract.IncotermStep;
import com.nicico.sales.utility.SecurityChecker;
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

        SecurityChecker.addEntityPermissionToRequest(request, IncotermStep.class);

        return "contract/incoterm-step";
    }
}
