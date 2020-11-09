package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.entities.base.InspectionReport;
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
import java.util.ArrayList;
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

        Map<String, List<String>> inspectionRateValueTypes = new HashMap<>();
        List<String> valueTypeEnList = new ArrayList<>();
        List<String> valueTypeFaList = new ArrayList<>();
        for (InspectionRateValueType value : InspectionRateValueType.values()) {
            valueTypeEnList.add(value.getNameEN());
            valueTypeFaList.add(value.getNameFA());
        }
        inspectionRateValueTypes.put("nameEn", valueTypeEnList);
        inspectionRateValueTypes.put("nameFa", valueTypeFaList);
        request.setAttribute("Enum_InspectionRateValueType", objectMapper.writeValueAsString(inspectionRateValueTypes));

        Map<String, List<String>> weighingType = new HashMap<>();
        List<String> weighingTypeEnList = new ArrayList<>();
        List<String> weighingTypeFaList = new ArrayList<>();
        for (WeighingType value : WeighingType.values()) {
            weighingTypeEnList.add(value.getNameEN());
            weighingTypeFaList.add(value.getNameFA());
        }
        weighingType.put("nameEn", weighingTypeEnList);
        weighingType.put("nameFa", weighingTypeFaList);
        request.setAttribute("Enum_WeighingType", objectMapper.writeValueAsString(weighingType));

        Map<String, List<String>> mileStone = new HashMap<>();
        List<String> mileStoneEnList = new ArrayList<>();
        List<String> mileStoneFaList = new ArrayList<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values()) {
            mileStoneEnList.add(value.getNameEN());
            mileStoneFaList.add(value.getNameFA());
        }
        mileStone.put("nameEn", mileStoneEnList);
        mileStone.put("nameFa", mileStoneFaList);
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        SecurityChecker.addEntityPermissionToRequest(request, InspectionReport.class);

        return "inspectionReport/inspectionReport";
    }

    @PostMapping("/import-data")
    public ResponseEntity<List<Map<String, Object>>> importFromExcel(@RequestParam("file") MultipartFile file, @RequestParam("recordLimit") Integer recordLimit, @RequestParam("fieldNames") List<String> fieldNames) throws IOException {

        if (file.isEmpty()) throw new SalesException2(ErrorType.NotFound, "file", "Excel file not found.");

        List<Map<String, Object>> data = excelInputUtil.getData(0, recordLimit, file.getInputStream(), fieldNames);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }
}