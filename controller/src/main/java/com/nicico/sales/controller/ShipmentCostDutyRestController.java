package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.dto.ShipmentCostDutyDTO;
import com.nicico.sales.iservice.IShipmentCostDutyService;
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
@RequestMapping(value = "/api/costDuty")
public class ShipmentCostDutyRestController {

    private final IShipmentCostDutyService iCostDutyService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentCostDutyDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iCostDutyService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentCostDutyDTO.Info>> list() {
        return new ResponseEntity<>(iCostDutyService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentCostDutyDTO.Info> create(@Validated @RequestBody ShipmentCostDutyDTO.Create request) {
        return new ResponseEntity<>(iCostDutyService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentCostDutyDTO.Info> update(@RequestBody ShipmentCostDutyDTO.Update request) {
        return new ResponseEntity<>(iCostDutyService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iCostDutyService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @Report(nameKey = "entity.shipment-cost-duty")
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentCostDutyDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iCostDutyService.search(nicicoCriteria), HttpStatus.OK);
    }
}
