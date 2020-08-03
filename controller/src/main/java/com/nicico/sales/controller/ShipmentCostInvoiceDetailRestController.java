package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.iservice.IShipmentCostInvoiceDetailService;
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
@RequestMapping(value = "/api/shipmentCostInvoiceDetail")

public class ShipmentCostInvoiceDetailRestController {

    private final IShipmentCostInvoiceDetailService iShipmentCostInvoiceDetailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentCostInvoiceDetailDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iShipmentCostInvoiceDetailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentCostInvoiceDetailDTO.Info>> list() {
        return new ResponseEntity<>(iShipmentCostInvoiceDetailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentCostInvoiceDetailDTO.Info> create(@Validated @RequestBody ShipmentCostInvoiceDetailDTO.Create request) {
        return new ResponseEntity<>(iShipmentCostInvoiceDetailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentCostInvoiceDetailDTO.Info> update(@RequestBody ShipmentCostInvoiceDetailDTO.Update request) {
        return new ResponseEntity<>(iShipmentCostInvoiceDetailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iShipmentCostInvoiceDetailService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentCostInvoiceDetailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iShipmentCostInvoiceDetailService.search(nicicoCriteria), HttpStatus.OK);
    }
}
