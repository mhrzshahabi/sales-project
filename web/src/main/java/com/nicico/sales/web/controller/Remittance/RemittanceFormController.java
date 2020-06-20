package com.nicico.sales.web.controller.Remittance;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/remittance")
public class RemittanceFormController {

    @RequestMapping("/showForm")
    public String showRemittance() {
        return "remittance/remittance";
    }
}

