package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseCadDTO;
import com.nicico.sales.iservice.IWarehouseCadService;
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
@RequestMapping(value = "/api/warehouseCad")
public class WarehouseCadRestController {

    private final IWarehouseCadService warehouseCadService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseCadDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseCadService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseCadDTO.Info>> list() {
        return new ResponseEntity<>(warehouseCadService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseCadDTO.Info> create(@Validated @RequestBody WarehouseCadDTO.Create request) {
        return new ResponseEntity<>(warehouseCadService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseCadDTO.Info> update(@RequestBody WarehouseCadDTO.Update request) {
        return new ResponseEntity<>(warehouseCadService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseCadService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseCadDTO.Delete request) {
        warehouseCadService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseCadDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseCadService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list-issue-cad")
    public ResponseEntity<TotalResponse<WarehouseCadDTO.InfoCombo>> list1(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseCadService.search1(nicicoCriteria), HttpStatus.OK);
    }
}
