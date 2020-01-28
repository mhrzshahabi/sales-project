package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseIssueMoDTO;
import com.nicico.sales.iservice.IWarehouseIssueMoService;
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
@RequestMapping(value = "/api/warehouseIssueMo")
public class WarehouseIssueMoRestController {

    private final IWarehouseIssueMoService warehouseIssueMoService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseIssueMoDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseIssueMoService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseIssueMoDTO.Info>> list() {
        return new ResponseEntity<>(warehouseIssueMoService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseIssueMoDTO.Info> create(@Validated @RequestBody WarehouseIssueMoDTO.Create request) {
        return new ResponseEntity<>(warehouseIssueMoService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseIssueMoDTO.Info> update(@RequestBody WarehouseIssueMoDTO.Update request) {
        return new ResponseEntity<>(warehouseIssueMoService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseIssueMoService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseIssueMoDTO.Delete request) {
        warehouseIssueMoService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseIssueMoDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseIssueMoService.search(nicicoCriteria), HttpStatus.OK);
    }
}
