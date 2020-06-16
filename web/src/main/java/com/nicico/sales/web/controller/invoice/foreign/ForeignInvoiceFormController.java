package com.nicico.sales.web.controller.invoice.foreign;

import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/foreign-invoice")
public class ForeignInvoiceFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        request.setAttribute("c_entity", SecurityChecker.check("" +
                "hasAuthority('C_FOREIGNINVOICE') AND " +
                "hasAuthority('C_FOREIGNINVOICEITEM') AND " +
                "hasAuthority('C_FOREIGNINVOICEITEMDETAIL') AND " +
                "hasAuthority('C_FOREIGNINVOICEPAYMENT')"));
        request.setAttribute("u_entity", SecurityChecker.check("" +
                "hasAuthority('U_FOREIGNINVOICE') AND " +
                "hasAuthority('U_FOREIGNINVOICEITEM') AND " +
                "hasAuthority('U_FOREIGNINVOICEITEMDETAIL') AND " +
                "hasAuthority('U_FOREIGNINVOICEPAYMENT')"));
        request.setAttribute("d_entity", SecurityChecker.check("" +
                "hasAuthority('D_FOREIGNINVOICE') AND " +
                "hasAuthority('D_FOREIGNINVOICEITEM') AND " +
                "hasAuthority('D_FOREIGNINVOICEITEMDETAIL') AND " +
                "hasAuthority('D_FOREIGNINVOICEPAYMENT')"));
        return "contract2/incoterm";
    }
}
