package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    private final ObjectMapper objectMapper;

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
    @GetMapping(value = "/spec-list")
    public ResponseEntity<ContractDTO.ContractSpecRs> list(@RequestParam("_startRow") Integer startRow,
                                                           @RequestParam("_endRow") Integer endRow,
                                                           @RequestParam(value = "_constructor", required = false) String constructor,
                                                           @RequestParam(value = "operator", required = false) String operator,
                                                           @RequestParam(value = "_sortBy", required = false) String sortBy,
                                                           @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        SearchDTO.CriteriaRq criteriaRq;
        if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
            criteria = "[" + criteria + "]";
            criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (StringUtils.isNotEmpty(sortBy)) {
                request.setSortBy(sortBy);
            }

            request.setCriteria(criteriaRq);
        }

        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<ContractDTO.Info> response = contractService.search(request);

        final ContractDTO.SpecRs specResponse = new ContractDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final ContractDTO.ContractSpecRs specRs = new ContractDTO.ContractSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<ContractDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractService.search(request), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/writeWord")
    public ResponseEntity<ContractDTO.Info> saveValueAllArticles(@RequestBody String request) {
        contractService.writeToWord(request);
        return new ResponseEntity(HttpStatus.OK);
    }
    @Loggable
    @PutMapping(value = "/readWord")
    public ResponseEntity<List<String>> updateValueAllArticles(@RequestBody String contractNo) {
        return new ResponseEntity<>(contractService.readFromWord(contractNo), HttpStatus.OK);
    }
}
