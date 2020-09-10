package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/g-contract")
public class ContractRestController2 {

    private final SpecListUtil specListUtil;
    private final IContractService2 contractService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDTO2.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDTO2.Info>> list() {

        return new ResponseEntity<>(contractService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDTO2.Info> create(@Validated @RequestBody ContractDTO2.Create request) {

        return new ResponseEntity<>(contractService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDTO2.Info> update(@Validated @RequestBody ContractDTO2.Update request) {

        return new ResponseEntity<>(contractService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDTO2.Delete request) {

        contractService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDTO2.ListGridInfo>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractService.refinedSearch(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/latest-version-of-data/{contractId}/{code}/{contractDetailValueKey}")
    public ResponseEntity<List<Object>> latestVersionOfData(@PathVariable String contractDetailValueKey,
                                                            @PathVariable Long contractId,
                                                            @PathVariable String code) {
        return new ResponseEntity<>(contractService.getOperationalDataOfContractArticle(contractId,
                code, contractDetailValueKey), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/latest-version-of-data-response")
    public ResponseEntity<Map<String, Object>> latestVersionOfDataResponse(
            @RequestParam String code,
            @RequestParam String contractDetailValueKey,
            @RequestParam(required = false) Long contractId) {

        return new ResponseEntity<>(specListUtil.getCoveredByResponse(
                contractService.getOperationalDataOfContractArticle(contractId,
                        code, contractDetailValueKey)), HttpStatus.OK);
    }
}
