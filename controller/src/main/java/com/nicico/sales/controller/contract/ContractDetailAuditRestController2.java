package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailAuditDTO2;
import com.nicico.sales.iservice.contract.IContractDetailAuditService2;
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
@RequestMapping(value = "/api/g-contract-detail-audit")
public class ContractDetailAuditRestController2 {

    private final IContractDetailAuditService2 contractDetailAuditService;

    @Loggable
    @GetMapping(value = "/")
    public ResponseEntity<ContractDetailAuditDTO2.Info> get(@RequestBody AuditId auditId) {

        return new ResponseEntity<>(contractDetailAuditService.get(auditId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailAuditDTO2.Info>> list() {

        return new ResponseEntity<>(contractDetailAuditService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailAuditDTO2.Info> create(@Validated @RequestBody ContractDetailAuditDTO2.Create request) {

        return new ResponseEntity<>(contractDetailAuditService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailAuditDTO2.Info> update(@Validated @RequestBody ContractDetailAuditDTO2.Update request) {

        return new ResponseEntity<>(contractDetailAuditService.update(request.getAuditId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/")
    public ResponseEntity<Void> delete(@RequestBody AuditId auditId) {

        contractDetailAuditService.delete(auditId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailAuditDTO2.Delete request) {

        contractDetailAuditService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailAuditDTO2.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailAuditService.search(nicicoCriteria), HttpStatus.OK);
    }
}
