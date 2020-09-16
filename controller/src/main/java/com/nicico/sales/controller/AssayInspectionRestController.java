package com.nicico.sales.controller;

import com.google.common.base.Enums;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/assayInspection")

public class AssayInspectionRestController {

    private final IAssayInspectionService iAssayInspectionService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<AssayInspectionDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iAssayInspectionService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<AssayInspectionDTO.Info>> list() {
        return new ResponseEntity<>(iAssayInspectionService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<AssayInspectionDTO.Info> create(@Validated @RequestBody AssayInspectionDTO.Create request) {
        return new ResponseEntity<>(iAssayInspectionService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<AssayInspectionDTO.Info> update(@RequestBody AssayInspectionDTO.Update request) {
        return new ResponseEntity<>(iAssayInspectionService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iAssayInspectionService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<AssayInspectionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iAssayInspectionService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-assay-values")
    public ResponseEntity<List<AssayInspectionDTO.InfoWithoutInspectionReport>> getAssayValues(@RequestParam Long shipmentId, @RequestParam String reportMilestone, @RequestParam List<Long> inventoryIds) {
//InfoWithoutInspectionReportAndInventory
        InspectionReportMilestone reportMilestoneEnum = Enums.getIfPresent(InspectionReportMilestone.class, reportMilestone).or(InspectionReportMilestone.Source);
        return new ResponseEntity<>(iAssayInspectionService.getAssayValues(shipmentId, reportMilestoneEnum, inventoryIds), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-assay-inventory-data")
    public ResponseEntity<List<AssayInspectionDTO.Info>> getAssayInventoryData(@RequestParam String reportMilestone, @RequestParam List<Long> inventoryIds) {
        InspectionReportMilestone reportMilestoneEnum = Enums.getIfPresent(InspectionReportMilestone.class, reportMilestone).or(InspectionReportMilestone.Source);
        return new ResponseEntity<>(iAssayInspectionService.getAssayInventoryData(reportMilestoneEnum, inventoryIds), HttpStatus.OK);
    }
}
