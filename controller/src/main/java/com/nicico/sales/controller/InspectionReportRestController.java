package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.iservice.IInspectionReportService;
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
@RequestMapping(value = "/api/inspectionReport")

public class InspectionReportRestController {

    private final IInspectionReportService iInspectionReportService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InspectionReportDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iInspectionReportService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InspectionReportDTO.Info>> list() {
        return new ResponseEntity<>(iInspectionReportService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InspectionReportDTO.Info> create(@Validated @RequestBody InspectionReportDTO.Create request) {
        return new ResponseEntity<>(iInspectionReportService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PostMapping(value = "/activate/{id}")
    public ResponseEntity<InspectionReportDTO.Info> activate(@PathVariable Long id) {

        return new ResponseEntity<>(iInspectionReportService.activate(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/deactivate/{id}")
    public ResponseEntity<InspectionReportDTO.Info> deactivate(@PathVariable Long id) {

        return new ResponseEntity<>(iInspectionReportService.deactivate(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/finalize/{id}")
    public ResponseEntity<InspectionReportDTO.Info> finalize(@PathVariable Long id) {

        return new ResponseEntity<>(iInspectionReportService.finalize(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/disapprove/{id}")
    public ResponseEntity<InspectionReportDTO.Info> disapprove(@PathVariable Long id) {

        return new ResponseEntity<>(iInspectionReportService.disapprove(id), HttpStatus.OK);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InspectionReportDTO.Info> update(@RequestBody InspectionReportDTO.Update request) {
        return new ResponseEntity<>(iInspectionReportService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iInspectionReportService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InspectionReportDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iInspectionReportService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/set-shipment")
    public ResponseEntity<InspectionReportDTO.Info> setShipment(@RequestParam("inspectionId") Long inspectionId, @RequestParam("shipmentId") Long shipmentId) {
        return new ResponseEntity<>(iInspectionReportService.setShipment(inspectionId, shipmentId), HttpStatus.OK);
    }
}
