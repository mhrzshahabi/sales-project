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
                "hasAuthority('C_FOREIGN_INVOICE') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('C_FOREIGN_INVOICE_PAYMENT')"));
        request.setAttribute("u_entity", SecurityChecker.check("" +
                "hasAuthority('U_FOREIGN_INVOICE') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('U_FOREIGN_INVOICE_PAYMENT')"));
        request.setAttribute("d_entity", SecurityChecker.check("" +
                "hasAuthority('D_FOREIGN_INVOICE') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_ITEM') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_ITEM_DETAIL') AND " +
                "hasAuthority('D_FOREIGN_INVOICE_PAYMENT')"));
        return "invoice/foreign/foreign-invoice";
    }
}
