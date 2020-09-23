package com.nicico.sales.web.controller.contract;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/generatorDynamicForm")
public class GeneratorDynamicForm {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {
        return "contract/Component-dynamicForm-generator";
    }

    @RequestMapping("/show-header")
    public String showHeader(HttpServletRequest request) {
        return "contract/Component-header-contract";
    }

}





