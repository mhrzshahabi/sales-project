package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AssayInspectionTotalValuesDTO;
import com.nicico.sales.iservice.IAssayInspectionTotalValuesService;
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
@RequestMapping(value = "/api/assayInspectionTotalValues")

public class AssayInspectionTotalValuesRestController {

    private final IAssayInspectionTotalValuesService iAssayInspectionTotalValuesService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<AssayInspectionTotalValuesDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iAssayInspectionTotalValuesService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<AssayInspectionTotalValuesDTO.Info>> list() {
        return new ResponseEntity<>(iAssayInspectionTotalValuesService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<AssayInspectionTotalValuesDTO.Info> create(@Validated @RequestBody AssayInspectionTotalValuesDTO.Create request) {
        return new ResponseEntity<>(iAssayInspectionTotalValuesService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<AssayInspectionTotalValuesDTO.Info> update(@RequestBody AssayInspectionTotalValuesDTO.Update request) {
        return new ResponseEntity<>(iAssayInspectionTotalValuesService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iAssayInspectionTotalValuesService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<AssayInspectionTotalValuesDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iAssayInspectionTotalValuesService.search(nicicoCriteria), HttpStatus.OK);
    }
}
