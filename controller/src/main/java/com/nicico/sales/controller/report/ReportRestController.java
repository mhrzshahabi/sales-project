package com.nicico.sales.controller.report;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.service.ReportService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/report")
public class ReportRestController {

    private final ReportService reportService;

    @Loggable
    @GetMapping()
    public ResponseEntity<List<ReportDTO.RestData>> get() {
        return new ResponseEntity<>(reportService.getAllRest(), HttpStatus.OK);
    }

}
