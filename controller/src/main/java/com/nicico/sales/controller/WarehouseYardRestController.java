package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseYardDTO;
import com.nicico.sales.iservice.IWarehouseYardService;
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
@RequestMapping(value = "/api/warehouseYard")
public class WarehouseYardRestController {

    private final IWarehouseYardService warehouseYardService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseYardDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseYardService.get(id), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseYardDTO.Info>> list() {
        return new ResponseEntity<>(warehouseYardService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseYardDTO.Info> create(@Validated @RequestBody WarehouseYardDTO.Create request) {
        return new ResponseEntity<>(warehouseYardService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseYardDTO.Info> update(@RequestBody WarehouseYardDTO.Update request) {
        return new ResponseEntity<>(warehouseYardService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseYardService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseYardDTO.Delete request) {
        warehouseYardService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseYardDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseYardService.search(nicicoCriteria), HttpStatus.OK);
    }
}
