package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Country;
import com.nicico.sales.utility.SecurityChecker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/base-country")
public class CountryFormController {

    @RequestMapping("/show-form")
    public String showCountry(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Country.class);

        return "base/country/country";
    }
}
