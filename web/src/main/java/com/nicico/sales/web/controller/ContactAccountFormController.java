package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.utility.SecurityChecker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/contactAccount")
public class ContactAccountFormController {

    @RequestMapping("/showForm")
    public String showContactAccount(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, ContactAccount.class);

        return "base/contactAccount";
    }
}
