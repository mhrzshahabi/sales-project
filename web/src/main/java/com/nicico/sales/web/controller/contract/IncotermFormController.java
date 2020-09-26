package com.nicico.sales.web.controller.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.*;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

import java.util.List;

import static com.nicico.sales.enumeration.ActionType.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/incoterm")
public class IncotermFormController {

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) {

        SecurityChecker.addEntityPermissionToRequest(request,
                Incoterm.class,
                IncotermSteps.class,
                IncotermRules.class,
                IncotermForms.class,
                IncotermDetail.class,
                IncotermParties.class);

        return "contract2/incoterm";
    }
}
