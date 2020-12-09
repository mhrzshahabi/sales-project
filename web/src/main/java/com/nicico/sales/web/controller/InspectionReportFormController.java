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
import com.nicico.sales.utility.MakeExcelOutputUtil;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@RequiredArgsConstructor
@Controller
@RequestMapping("/inspectionReport")
public class InspectionReportFormController {

    private final ObjectMapper objectMapper;
    private final MakeExcelInputUtil excelInputUtil;
    private final MakeExcelOutputUtil excelOutputUtil;
    private final ResourceBundleMessageSource messageSource;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        Map<String, String> inspectionRateValueTypes = getRateValueTypeEnumMap();
        request.setAttribute("Enum_InspectionRateValueType", objectMapper.writeValueAsString(inspectionRateValueTypes));

        Map<String, String> weighingType = getWeighingTypeEnumMap();
        request.setAttribute("Enum_WeighingType", objectMapper.writeValueAsString(weighingType));

        Map<String, String> mileStone = getMileStoneEnumMap();
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        SecurityChecker.addEntityPermissionToRequest(request, InspectionReport.class);

        return "inspectionReport/inspectionReport";
    }

    private Map<String, String> getRateValueTypeEnumMap() {

        Map<String, String> type = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (InspectionRateValueType value : InspectionRateValueType.values())
            if (value == InspectionRateValueType.ManPerDay)
                type.put(value.name(), messageSource.getMessage("enum.inspectionRateValueType.man.per.day", null, locale));
            else if (value == InspectionRateValueType.PerTon)
                type.put(value.name(), messageSource.getMessage("enum.inspectionRateValueType.per.ton", null, locale));
            else throw new SalesException2(ErrorType.InvalidData, null, "تعریف نشده است");

        return type;
    }

    private Map<String, String> getWeighingTypeEnumMap() {

        Map<String, String> type = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (WeighingType value : WeighingType.values())
            if (value == WeighingType.DraftSurvey)
                type.put(value.name(), messageSource.getMessage("enum.WeighingType.draft.survey", null, locale));
            else if (value == WeighingType.WeighBridge)
                type.put(value.name(), messageSource.getMessage("enum.WeighingType.weight.Bridge", null, locale));
            else throw new SalesException2(ErrorType.InvalidData, null, "تعریف نشده است");

        return type;
    }

    private Map<String, String> getMileStoneEnumMap() {

        Map<String, String> type = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (InspectionReportMilestone value : InspectionReportMilestone.values())
            if (value == InspectionReportMilestone.Source)
                type.put(value.name(), messageSource.getMessage("enum.inspectionReportMilestone.source", null, locale));
            else if (value == InspectionReportMilestone.Destination)
                type.put(value.name(), messageSource.getMessage("enum.inspectionReportMilestone.destination", null, locale));
            else if (value == InspectionReportMilestone.Umpire)
                type.put(value.name(), messageSource.getMessage("enum.inspectionReportMilestone.umpire", null, locale));
            else throw new SalesException2(ErrorType.InvalidData, null, "تعریف نشده است");

        return type;
    }

    @PostMapping("/import-data")
    public ResponseEntity<List<Map<String, Object>>> importFromExcel(
            @RequestParam("file") MultipartFile file,
            @RequestParam("recordLimit") Integer recordLimit,
            @RequestParam("fieldNames") List<String> fieldNames) throws IOException {

        if (file.isEmpty()) throw new SalesException2(ErrorType.NotFound, "file", "Excel file not found.");

        List<Map<String, Object>> data = excelInputUtil.getData(0, recordLimit, file.getInputStream(), fieldNames);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }

    @RequestMapping("/export")
    public void exportExcel(
            @RequestParam("headers") String[] headers,
            @RequestParam("fieldNames") String[] fieldNames,
            HttpServletResponse response) throws Exception {

        byte[] bytes = excelOutputUtil.makeOutput(new ArrayList<>(), InspectionReport.class, fieldNames, headers, true, "");
        excelOutputUtil.makeExcelResponse(bytes, response);
    }
}