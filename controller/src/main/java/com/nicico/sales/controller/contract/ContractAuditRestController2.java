package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractAuditDTO2;
import com.nicico.sales.iservice.contract.IContractAuditService2;
import com.nicico.sales.model.entities.common.AuditId;
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
@RequestMapping(value = "/api/g-contract-audit")
public class ContractAuditRestController2 {

    private final IContractAuditService2 contractAuditService;

    @Loggable
    @GetMapping(value = "/")
    public ResponseEntity<ContractAuditDTO2.Info> get(@RequestBody AuditId auditId) {

        return new ResponseEntity<>(contractAuditService.get(auditId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractAuditDTO2.Info>> list() {

        return new ResponseEntity<>(contractAuditService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractAuditDTO2.Info> create(@Validated @RequestBody ContractAuditDTO2.Create request) {

        return new ResponseEntity<>(contractAuditService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractAuditDTO2.Info> update(@RequestBody ContractAuditDTO2.Update request) {

        return new ResponseEntity<>(contractAuditService.update(request.getAuditId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/")
    public ResponseEntity<Void> delete(@RequestBody AuditId auditId) {

        contractAuditService.delete(auditId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractAuditDTO2.Delete request) {

        contractAuditService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractAuditDTO2.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractAuditService.search(nicicoCriteria), HttpStatus.OK);
    }
}
