package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CurrencyDTO;
import com.nicico.sales.iservice.ICurrencyService;
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
@RequestMapping(value = "/api/currency")
public class CurrencyRestController {

    private final ICurrencyService currencyService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<CurrencyDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(currencyService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<CurrencyDTO.Info>> list() {
        return new ResponseEntity<>(currencyService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<CurrencyDTO.Info> create(@Validated @RequestBody CurrencyDTO.Create request) {
        return new ResponseEntity<>(currencyService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<CurrencyDTO.Info> update(@RequestBody CurrencyDTO.Update request) {
        return new ResponseEntity<>(currencyService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        currencyService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody CurrencyDTO.Delete request) {
        currencyService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<CurrencyDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(currencyService.search(nicicoCriteria), HttpStatus.OK);
    }
}
