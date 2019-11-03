package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.iservice.IBankService;
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
@RequestMapping(value = "/api/bank")
public class BankRestController {

    private final IBankService bankService;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<BankDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(bankService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<BankDTO.Info>> list() {
        return new ResponseEntity<>(bankService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<BankDTO.Info> create(@Validated @RequestBody BankDTO.Create request) {
        return new ResponseEntity<>(bankService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<BankDTO.Info> update(@RequestBody BankDTO.Update request) {
        return new ResponseEntity<>(bankService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        bankService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody BankDTO.Delete request) {
        bankService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<BankDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(bankService.search(nicicoCriteria), HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<BankDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(bankService.search(request), HttpStatus.OK);
    }
}
