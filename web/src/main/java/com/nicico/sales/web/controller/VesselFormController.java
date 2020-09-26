package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Vessel;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/vessel")
public class VesselFormController {

    @RequestMapping("/showForm")
    public String showTerm(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Vessel.class);

        return "vessel/vessel";
    }
}
