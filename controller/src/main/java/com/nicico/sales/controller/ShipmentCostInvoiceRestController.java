package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentCostInvoiceDTO;
import com.nicico.sales.iservice.IShipmentCostInvoiceService;
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
@RequestMapping(value = "/api/shipmentCostInvoice")

public class ShipmentCostInvoiceRestController {

    private final IShipmentCostInvoiceService iShipmentCostInvoiceService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentCostInvoiceDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iShipmentCostInvoiceService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentCostInvoiceDTO.Info>> list() {
        return new ResponseEntity<>(iShipmentCostInvoiceService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentCostInvoiceDTO.Info> create(@Validated @RequestBody ShipmentCostInvoiceDTO.Create request) {
        return new ResponseEntity<>(iShipmentCostInvoiceService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentCostInvoiceDTO.Info> update(@RequestBody ShipmentCostInvoiceDTO.Update request) {
        return new ResponseEntity<>(iShipmentCostInvoiceService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iShipmentCostInvoiceService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/finalize/{id}")
    public ResponseEntity finalize(@PathVariable Long id) {
        iShipmentCostInvoiceService.finalize(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentCostInvoiceDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iShipmentCostInvoiceService.search(nicicoCriteria), HttpStatus.OK);
    }
}
