package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/instruction")
public class InstructionFormController {

    @RequestMapping("/showForm")
    public String showInstruction() {
        return "base/instruction";
    }
}
