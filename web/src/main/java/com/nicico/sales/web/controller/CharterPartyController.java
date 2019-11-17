package com.nicico.sales.web.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/charter")
public class CharterPartyController {


    @RequestMapping("/showForm")
    public String showPaymentOption() {
        return "base/charter";
    }


}
