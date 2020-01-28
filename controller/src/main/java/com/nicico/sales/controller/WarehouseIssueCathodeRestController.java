package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseIssueCathodeDTO;
import com.nicico.sales.iservice.IWarehouseIssueCathodeService;
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
@RequestMapping(value = "/api/warehouseIssueCathode")
public class WarehouseIssueCathodeRestController {

    private final IWarehouseIssueCathodeService warehouseIssueCathodeService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseIssueCathodeDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseIssueCathodeService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseIssueCathodeDTO.Info>> list() {
        return new ResponseEntity<>(warehouseIssueCathodeService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseIssueCathodeDTO.Info> create(@Validated @RequestBody WarehouseIssueCathodeDTO.Create request) {
        return new ResponseEntity<>(warehouseIssueCathodeService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseIssueCathodeDTO.Info> update(@RequestBody WarehouseIssueCathodeDTO.Update request) {
        return new ResponseEntity<>(warehouseIssueCathodeService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseIssueCathodeService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseIssueCathodeDTO.Delete request) {
        warehouseIssueCathodeService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseIssueCathodeDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseIssueCathodeService.search(nicicoCriteria), HttpStatus.OK);
    }
}
