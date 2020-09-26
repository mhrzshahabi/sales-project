package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.model.enumeration.InspectionRateValueType;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.WeighingType;
import com.nicico.sales.utility.MakeExcelInputUtil;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/inspectionReport")
public class InspectionReportFormController {

    private final ObjectMapper objectMapper;
    private final MakeExcelInputUtil excelInputUtil;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> inspectionRateValueTypes = new HashMap<>();
        for (InspectionRateValueType value : InspectionRateValueType.values())
            inspectionRateValueTypes.put(value.name(), value.name());
        request.setAttribute("Enum_InspectionRateValueType", objectMapper.writeValueAsString(inspectionRateValueTypes));

        Map<String, String> weighingType = new HashMap<>();
        for (WeighingType value : WeighingType.values()) weighingType.put(value.name(), value.name());
        request.setAttribute("Enum_WeighingType", objectMapper.writeValueAsString(weighingType));

        Map<String, String> mileStone = new HashMap<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values())
            mileStone.put(value.name(), value.name());
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        SecurityChecker.addEntityPermissionToRequest(request, IncotermAspect.class);

        return "inspectionReport/inspectionReport";
    }

    @PostMapping
    public ResponseEntity<List<Map<String, Object>>> importFromExcel(
            @RequestParam("file") MultipartFile file,
            @RequestParam("recordLimit") Integer recordLimit,
            @RequestParam("fieldNames") List<String> fieldNames) throws IOException {

        if (file.isEmpty()) throw new SalesException2(ErrorType.NotFound, "file", "Excel file not found.");

        List<Map<String, Object>> data = excelInputUtil.getData(0, recordLimit, file.getInputStream(), fieldNames);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }
}