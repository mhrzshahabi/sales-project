package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractIncomeCost")
public class ContractIncomeCostRestController {

    private final IContractIncomeCostService contractIncomeCostService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractIncomeCostDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractIncomeCostService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractIncomeCostDTO.Info>> list() {
        return new ResponseEntity<>(contractIncomeCostService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<ContractIncomeCostDTO.ContractIncomeCostSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<ContractIncomeCostDTO.Info> response = contractIncomeCostService.search(request);

        final ContractIncomeCostDTO.SpecRs specResponse = new ContractIncomeCostDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final ContractIncomeCostDTO.ContractIncomeCostSpecRs specRs = new ContractIncomeCostDTO.ContractIncomeCostSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<ContractIncomeCostDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractIncomeCostService.search(request), HttpStatus.OK);
    }
}
