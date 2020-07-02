package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialElementDTO;
import com.nicico.sales.iservice.IMaterialElementService;
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
@RequestMapping(value = "/api/materialElement")

public class MaterialElementRestController {

    private final IMaterialElementService iMaterialElementService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<MaterialElementDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iMaterialElementService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<MaterialElementDTO.Info>> list() {
        return new ResponseEntity<>(iMaterialElementService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<MaterialElementDTO.Info> create(@Validated @RequestBody MaterialElementDTO.Create request) {
        return new ResponseEntity<>(iMaterialElementService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<MaterialElementDTO.Info> update(@RequestBody MaterialElementDTO.Update request) {
        return new ResponseEntity<>(iMaterialElementService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iMaterialElementService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<MaterialElementDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iMaterialElementService.search(nicicoCriteria), HttpStatus.OK);
    }
}
