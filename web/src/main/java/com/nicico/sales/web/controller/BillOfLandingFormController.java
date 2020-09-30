package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/bill-of-landing")
public class BillOfLandingFormController {

    @GetMapping(value = "show-form")
    public String showHomePage(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request, BillOfLanding.class);

        return "contract/bill-of-landing";
    }
}
