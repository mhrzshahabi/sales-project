package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.utility.SecurityChecker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/material")
public class MaterialFormController {
    @RequestMapping("/showForm")
    public String showMaterial(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Material.class);

        return "material/material";
    }
}
