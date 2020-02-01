package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractPersonDTO;
import com.nicico.sales.iservice.IContractPersonService;
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
@RequestMapping(value = "/api/contractPerson")
public class ContractPersonRestController {

    private final IContractPersonService contractPersonService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractPersonDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractPersonService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractPersonDTO.Info>> list() {
        return new ResponseEntity<>(contractPersonService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractPersonDTO.Info> create(@Validated @RequestBody ContractPersonDTO.Create request) {
        return new ResponseEntity<>(contractPersonService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractPersonDTO.Info> update(@RequestBody ContractPersonDTO.Update request) {
        return new ResponseEntity<>(contractPersonService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractPersonService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractPersonDTO.Delete request) {
        contractPersonService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractPersonDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractPersonService.search(nicicoCriteria), HttpStatus.OK);
    }
}
