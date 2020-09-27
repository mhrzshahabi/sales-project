package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/base-port")
public class PortFormController {


    @RequestMapping("/show-form")
    public String showPort(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, Port.class);

        return "base/port/port";
    }
}
