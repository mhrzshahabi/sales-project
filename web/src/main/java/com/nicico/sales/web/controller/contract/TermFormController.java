package com.nicico.sales.web.controller.contract;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/term")
public class TermFormController {

    @RequestMapping("/showForm")
    public String showTerm() {
        return "contract2/term";
    }
}
