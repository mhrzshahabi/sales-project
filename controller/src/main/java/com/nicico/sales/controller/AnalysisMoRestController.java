package com.nicico.sales.controller;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AnalysisMoDTO;
import com.nicico.sales.iservice.IAnalysisMoService;
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
@RequestMapping(value = "/api/analysisMo")
public class AnalysisMoRestController {

    private final IAnalysisMoService iAnalysisMoService;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<AnalysisMoDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iAnalysisMoService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<AnalysisMoDTO.Info>> list() {
        return new ResponseEntity<>(iAnalysisMoService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<AnalysisMoDTO.Info> create(@Validated @RequestBody AnalysisMoDTO.Create request) {
        return new ResponseEntity<>(iAnalysisMoService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<AnalysisMoDTO.Info> update(@RequestBody AnalysisMoDTO.Update request) {
        return new ResponseEntity<>(iAnalysisMoService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iAnalysisMoService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody AnalysisMoDTO.Delete request) {
        iAnalysisMoService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<AnalysisMoDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iAnalysisMoService.search(nicicoCriteria), HttpStatus.OK);
    }

}