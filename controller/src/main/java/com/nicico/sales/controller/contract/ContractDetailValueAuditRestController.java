package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailValueAuditDTO;
import com.nicico.sales.iservice.contract.IContractDetailValueAuditService;
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
@RequestMapping(value = "/api/contract-detail-value-audit")
public class ContractDetailValueAuditRestController {

    private final IContractDetailValueAuditService contractDetailValueAuditService;

    @Loggable
    @GetMapping(value = "/")
    public ResponseEntity<ContractDetailValueAuditDTO.Info> get(@RequestBody AuditId auditId) {

        return new ResponseEntity<>(contractDetailValueAuditService.get(auditId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailValueAuditDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailValueAuditService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailValueAuditDTO.Info> create(@Validated @RequestBody ContractDetailValueAuditDTO.Create request) {

        return new ResponseEntity<>(contractDetailValueAuditService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailValueAuditDTO.Info> update(@Validated @RequestBody ContractDetailValueAuditDTO.Update request) {

        return new ResponseEntity<>(contractDetailValueAuditService.update(request.getAuditId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/")
    public ResponseEntity<Void> delete(@RequestBody AuditId auditId) {

        contractDetailValueAuditService.delete(auditId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailValueAuditDTO.Delete request) {

        contractDetailValueAuditService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailValueAuditDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailValueAuditService.search(nicicoCriteria), HttpStatus.OK);
    }
}
