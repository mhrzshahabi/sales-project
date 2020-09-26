package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Person;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.utility.SecurityChecker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/person")
public class PersonFormController {

    @RequestMapping("/showForm")
    public String showPerson(HttpServletRequest request) {
        SecurityChecker.addEntityPermissionToRequest(request, Person.class);

        return "base/person";
    }
}
