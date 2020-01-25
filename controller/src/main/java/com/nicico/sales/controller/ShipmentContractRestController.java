package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentContractDTO;
import com.nicico.sales.iservice.IShipmentContractService;
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
@RequestMapping(value = "/api/shipmentContract")
public class ShipmentContractRestController {

    private final IShipmentContractService shipmentContractService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentContractDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentContractService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentContractDTO.Info>> list() {
        return new ResponseEntity<>(shipmentContractService.list(), HttpStatus.OK);
    }


    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentContractDTO.Info> create(@Validated @RequestBody ShipmentContractDTO.Create request) {
        return new ResponseEntity<>(shipmentContractService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentContractDTO.Info> update(@RequestBody ShipmentContractDTO.Update request) {
        return new ResponseEntity<>(shipmentContractService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentContractService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentContractDTO.Delete request) {
        shipmentContractService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentContractDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentContractService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<ShipmentContractDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(shipmentContractService.search(request), HttpStatus.OK);
    }
}
