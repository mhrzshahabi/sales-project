package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/assayInspection")
public class AssayInspectionFormController {

    @RequestMapping("/show-form")
    public String showTerm(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, AssayInspection.class);

        return "assayInspection/assayInspection";
    }
}
