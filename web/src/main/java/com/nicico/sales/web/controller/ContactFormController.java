package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.utility.SecurityChecker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/contact")
public class ContactFormController {

    @RequestMapping("/showForm")
    public String showContact(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Contact.class);

        return "base/contact";
    }

}
