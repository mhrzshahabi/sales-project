package com.nicico.sales.web.controller.contract;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoiceComps")
public class InvoiceCompFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        return "contract/invoiceComps";
    }
}
