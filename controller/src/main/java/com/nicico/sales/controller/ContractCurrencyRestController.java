package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractCurrencyDTO;
import com.nicico.sales.iservice.IContractCurrencyService;
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
@RequestMapping(value = "/api/contractCurrency")
public class ContractCurrencyRestController {

    private final IContractCurrencyService contractCurrencyService;

    @Loggable
    @GetMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('r_contractCurrency')")
    public ResponseEntity<ContractCurrencyDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractCurrencyService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('r_contractCurrency')")
    public ResponseEntity<List<ContractCurrencyDTO.Info>> list() {
        return new ResponseEntity<>(contractCurrencyService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    //	@PreAuthorize("hasAuthority('c_contractCurrency')")
    public ResponseEntity<ContractCurrencyDTO.Info> create(@Validated @RequestBody ContractCurrencyDTO.Create request) {
        return new ResponseEntity<>(contractCurrencyService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    //	@PreAuthorize("hasAuthority('u_contractCurrency')")
    public ResponseEntity<ContractCurrencyDTO.Info> update(@RequestBody ContractCurrencyDTO.Update request) {
        return new ResponseEntity<>(contractCurrencyService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('d_contractCurrency')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractCurrencyService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('d_contractCurrency')")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractCurrencyDTO.Delete request) {
        contractCurrencyService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractCurrencyDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractCurrencyService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    //	@PreAuthorize("hasAuthority('r_contractCurrency')")
    public ResponseEntity<SearchDTO.SearchRs<ContractCurrencyDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractCurrencyService.search(request), HttpStatus.OK);
    }
}
