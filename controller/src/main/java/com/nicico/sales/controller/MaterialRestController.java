package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialDTO;
import com.nicico.sales.iservice.IMaterialService;
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
@RequestMapping(value = "/api/material")
public class MaterialRestController {

    private final IMaterialService materialService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<MaterialDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(materialService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<MaterialDTO.Info>> list() {
        return new ResponseEntity<>(materialService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<MaterialDTO.Info> create(@Validated @RequestBody MaterialDTO.Create request) {
        return new ResponseEntity<>(materialService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<MaterialDTO.Info> update(@RequestBody MaterialDTO.Update request) {
        return new ResponseEntity<>(materialService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        materialService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody MaterialDTO.Delete request) {
        materialService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<MaterialDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(materialService.search(nicicoCriteria), HttpStatus.OK);
    }
}
