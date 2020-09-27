package com.nicico.sales.web.controller;

import com.nicico.sales.model.entities.base.ShipmentCostDuty;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/costDuty")
public class ShipmentCostDutyFormController {

    @RequestMapping("/showForm")
    public String showParameters(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request, ShipmentCostDuty.class);

        return "base/shipmentCostDuty/shipmentCostDuty";
    }
}
