package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Bank;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/bank")
public class BankFormController {

    @RequestMapping("/showForm")
    public String showBank(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Bank.class);

        return "base/bank";
    }
}
