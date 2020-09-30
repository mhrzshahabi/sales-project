package com.nicico.sales.web.controller.contract;

import com.nicico.sales.model.entities.contract.IncotermParty;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm-party")
public class IncotermPartyFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {
        SecurityChecker.addEntityPermissionToRequest(request, IncotermParty.class);
        return "contract/incoterm-party";
    }
}
