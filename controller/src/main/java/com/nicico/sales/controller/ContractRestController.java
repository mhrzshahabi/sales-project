package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractAuditDTO;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractAuditService;
import com.nicico.sales.iservice.IContractService;
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
@RequestMapping(value = "/api/contract")
public class ContractRestController {

    private final IContractService contractService;
    private final IContractAuditService contractAuditService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDTO.Info>> list() {
        return new ResponseEntity<>(contractService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDTO.Info> create(@Validated @RequestBody ContractDTO.Create request) {
        return new ResponseEntity<>(contractService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDTO.Info> update(@RequestBody ContractDTO.Update request) {
        return new ResponseEntity<>(contractService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDTO.Delete request) {
        contractService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list-audit")
    public ResponseEntity<TotalResponse<ContractAuditDTO.Info>> listAudit(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractAuditService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/writeWord")
    public ResponseEntity<ContractDTO.Info> saveValueAllArticles(@RequestBody String request) throws Exception {
        contractService.writeToWord(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @PutMapping(value = "/readWord")
    public ResponseEntity<List<String>> updateValueAllArticles(@RequestBody String contractNo) {
        return new ResponseEntity<>(contractService.readFromWord(contractNo), HttpStatus.OK);
    }
}
