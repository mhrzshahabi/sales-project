package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.WeighingType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/inspectionReport")
public class InspectionReportFormController {

    private final ObjectMapper objectMapper;


    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> inspectionRateValueTypes = new HashMap<>();
        for (InspectionRateValueType value : InspectionRateValueType.values()) inspectionRateValueTypes.put(value.name(), value.name());
        request.setAttribute("Enum_InspectionRateValueType", objectMapper.writeValueAsString(inspectionRateValueTypes));

        Map<String, String> weighingType = new HashMap<>();
        for (WeighingType value : WeighingType.values()) weighingType.put(value.name(), value.name());
        request.setAttribute("Enum_WeighingType", objectMapper.writeValueAsString(weighingType));

        Map<String, String> mileStone = new HashMap<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values()) mileStone.put(value.name(), value.name());
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        request.setAttribute("c_entity", SecurityUtil.hasAuthority("C_INSPECTION_REPORT"));
        request.setAttribute("u_entity", SecurityUtil.hasAuthority("U_INSPECTION_REPORT"));
        request.setAttribute("d_entity", SecurityUtil.hasAuthority("D_INSPECTION_REPORT"));

        return "inspectionReport/inspectionReport";
    }
}
