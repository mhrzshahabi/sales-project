package com.nicico.sales.controller;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TypicalAssayDTO;
import com.nicico.sales.iservice.ITypicalAssayService;
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
@RequestMapping(value = "/api/typicalAssay")
public class TypicalAssayRestController {

    private final ITypicalAssayService iTypicalAssayService;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<TypicalAssayDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iTypicalAssayService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<TypicalAssayDTO.Info>> list() {
        return new ResponseEntity<>(iTypicalAssayService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<TypicalAssayDTO.Info> create(@Validated @RequestBody TypicalAssayDTO.Create request) {
        return new ResponseEntity<>(iTypicalAssayService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<TypicalAssayDTO.Info> update(@RequestBody TypicalAssayDTO.Update request) {
        return new ResponseEntity<>(iTypicalAssayService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iTypicalAssayService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody TypicalAssayDTO.Delete request) {
        iTypicalAssayService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<TypicalAssayDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iTypicalAssayService.search(nicicoCriteria), HttpStatus.OK);
    }

}
