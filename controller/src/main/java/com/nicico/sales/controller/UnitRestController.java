package com.nicico.sales.controller;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.enumeration.CategoryUnit;
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
@RequestMapping(value = "/api/unit")
public class UnitRestController {

    private final IUnitService iUnitService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<UnitDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iUnitService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<UnitDTO.Info>> list() {
        return new ResponseEntity<>(iUnitService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<UnitDTO.Info>> updateUnits() {
        iUnitService.updateUnits();
        return new ResponseEntity<>(iUnitService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<UnitDTO.Info> create(@Validated @RequestBody UnitDTO.Create request) {
        return new ResponseEntity<>(iUnitService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<UnitDTO.Info> update(@RequestBody UnitDTO.Update request) {
        return new ResponseEntity<>(iUnitService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iUnitService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/category-unit")
    public ResponseEntity<CategoryUnit[]> EnumCategoryUnit() throws IOException {
        return new ResponseEntity<>(CategoryUnit.values(), HttpStatus.OK);
    }

     @Loggable
        @GetMapping(value = "/spec-list")
        public ResponseEntity<TotalResponse<UnitDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
            final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
            return new ResponseEntity<>(iUnitService.search(nicicoCriteria), HttpStatus.OK);
        }


}
