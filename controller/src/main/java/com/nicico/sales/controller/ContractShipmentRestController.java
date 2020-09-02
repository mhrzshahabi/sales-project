package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractShipmentAuditDTO;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.iservice.IContractShipmentService;
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
@RequestMapping(value = {"/api/contractShipment", "/api/ContractShipment"})
public class ContractShipmentRestController {

    private final IContractShipmentService contractShipmentService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractShipmentDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractShipmentService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractShipmentDTO.Info>> list() {
        return new ResponseEntity<>(contractShipmentService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/audit/list")
    public ResponseEntity<List<ContractShipmentAuditDTO.Info>> listAudit() {
        return new ResponseEntity<>(contractShipmentService.listAudit(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractShipmentDTO.Info> create(@Validated @RequestBody ContractShipmentDTO.Create request) {
        return new ResponseEntity<>(contractShipmentService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractShipmentDTO.Info> update(@RequestBody ContractShipmentDTO.Update request) {
        return new ResponseEntity<>(contractShipmentService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractShipmentService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractShipmentDTO.Delete request) {
        contractShipmentService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractShipmentDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractShipmentService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/audit/spec-list")
    public ResponseEntity<TotalResponse<ContractShipmentAuditDTO.Info>> listAuditSpec(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractShipmentService.searchAudit(nicicoCriteria), HttpStatus.OK);
    }
}
