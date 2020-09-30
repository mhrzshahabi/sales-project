package com.nicico.sales.web.controller;


import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/materialElement")
public class MaterialElementFormController {

    @RequestMapping("/show-form")
    public String showForm(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, MaterialElement.class);

        return "";
    }

}
