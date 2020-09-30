package com.nicico.sales.web.controller;


import com.nicico.sales.model.entities.base.InvoiceType;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceType")
public class InvoiceTypeFormController {

    @RequestMapping("/showForm")
    public String showInvoiceType(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, InvoiceType.class);

        return "invoicetype/invoiceType";
    }
}
