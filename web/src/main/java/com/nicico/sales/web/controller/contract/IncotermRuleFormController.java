package com.nicico.sales.web.controller.contract;

import com.nicico.sales.model.entities.contract.IncotermRule;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm-rule")
public class IncotermRuleFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, IncotermRule.class);

        return "contract/incoterm-rule";
    }
}
