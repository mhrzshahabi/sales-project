package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseIssueConsDTO;
import com.nicico.sales.iservice.IWarehouseIssueConsService;
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
@RequestMapping(value = "/api/warehouseIssueCons")
public class WarehouseIssueConsRestController {

    private final IWarehouseIssueConsService warehouseIssueConsService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseIssueConsDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseIssueConsService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseIssueConsDTO.Info>> list() {
        return new ResponseEntity<>(warehouseIssueConsService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseIssueConsDTO.Info> create(@Validated @RequestBody WarehouseIssueConsDTO.Create request) {
        return new ResponseEntity<>(warehouseIssueConsService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseIssueConsDTO.Info> update(@RequestBody WarehouseIssueConsDTO.Update request) {
        return new ResponseEntity<>(warehouseIssueConsService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseIssueConsService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseIssueConsDTO.Delete request) {
        warehouseIssueConsService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseIssueConsDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseIssueConsService.search(nicicoCriteria), HttpStatus.OK);
    }
}
