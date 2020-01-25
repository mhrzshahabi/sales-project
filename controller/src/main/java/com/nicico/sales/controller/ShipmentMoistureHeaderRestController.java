package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentMoistureHeaderDTO;
import com.nicico.sales.iservice.IShipmentMoistureHeaderService;
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
@RequestMapping(value = "/api/shipmentMoistureHeader")
public class ShipmentMoistureHeaderRestController {

    private final IShipmentMoistureHeaderService shipmentMoistureHeaderService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentMoistureHeaderDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentMoistureHeaderService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentMoistureHeaderDTO.Info>> list() {
        return new ResponseEntity<>(shipmentMoistureHeaderService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentMoistureHeaderDTO.Info> create(@Validated @RequestBody ShipmentMoistureHeaderDTO.Create request) {
        return new ResponseEntity<>(shipmentMoistureHeaderService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentMoistureHeaderDTO.Info> update(@RequestBody ShipmentMoistureHeaderDTO.Update request) {
        return new ResponseEntity<>(shipmentMoistureHeaderService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentMoistureHeaderService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentMoistureHeaderDTO.Delete request) {
        shipmentMoistureHeaderService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentMoistureHeaderDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentMoistureHeaderService.search(nicicoCriteria), HttpStatus.OK);
    }
}
