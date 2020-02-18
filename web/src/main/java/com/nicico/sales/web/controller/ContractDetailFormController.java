package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contractDetail")
public class ContractDetailFormController {

    @RequestMapping("/showForm")
    public String showContractDetail() {
        return "base/contractDetail";
    }
}
