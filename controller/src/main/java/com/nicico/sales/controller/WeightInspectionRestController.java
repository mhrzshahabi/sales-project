package com.nicico.sales.controller;

import com.google.common.base.Enums;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.enumeration.AllConverters;
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
@RequestMapping(value = "/api/weightInspection")

public class WeightInspectionRestController {

    private final IWeightInspectionService iWeightInspectionService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WeightInspectionDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iWeightInspectionService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WeightInspectionDTO.Info>> list() {
        return new ResponseEntity<>(iWeightInspectionService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WeightInspectionDTO.Info> create(@Validated @RequestBody WeightInspectionDTO.Create request) {
        return new ResponseEntity<>(iWeightInspectionService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WeightInspectionDTO.Info> update(@RequestBody WeightInspectionDTO.Update request) {
        return new ResponseEntity<>(iWeightInspectionService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iWeightInspectionService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-weight-values")
    public ResponseEntity<List<WeightInspectionDTO.InfoWithoutInspectionReport>> getWeightValues(@RequestParam Long shipmentId, @RequestParam String reportMilestone, @RequestParam List<Long> inventoryIds) {
//InfoWithoutInspectionReportAndInventory
        InspectionReportMilestone reportMilestoneEnum = Enums.getIfPresent(InspectionReportMilestone.class, reportMilestone).or(InspectionReportMilestone.Source);
        return new ResponseEntity<>(iWeightInspectionService.getWeightValues(shipmentId, reportMilestoneEnum, inventoryIds), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-weight-inventory-data")
    public ResponseEntity<List<Long>> getWeightInventoryData(@RequestParam String reportMilestone, @RequestParam List<Long> inventoryIds) {
        InspectionReportMilestone reportMilestoneEnum = Enums.getIfPresent(InspectionReportMilestone.class, reportMilestone).or(InspectionReportMilestone.Source);
        return new ResponseEntity<>(iWeightInspectionService.getWeightInventoryData(reportMilestoneEnum, inventoryIds), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WeightInspectionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iWeightInspectionService.search(nicicoCriteria), HttpStatus.OK);
    }
}
