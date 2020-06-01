package com.nicico.sales.controller;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AnalyseMoDTO;
import com.nicico.sales.iservice.IAnalyseMoService;
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
@RequestMapping(value = "/api/analyseMo")
public class AnalyseMoRestController {

    private final IAnalyseMoService iAnalyseMoService;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<AnalyseMoDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iAnalyseMoService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<AnalyseMoDTO.Info>> list() {
        return new ResponseEntity<>(iAnalyseMoService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<AnalyseMoDTO.Info> create(@Validated @RequestBody AnalyseMoDTO.Create request) {
        return new ResponseEntity<>(iAnalyseMoService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<AnalyseMoDTO.Info> update(@RequestBody AnalyseMoDTO.Update request) {
        return new ResponseEntity<>(iAnalyseMoService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iAnalyseMoService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody AnalyseMoDTO.Delete request) {
        iAnalyseMoService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<AnalyseMoDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iAnalyseMoService.search(nicicoCriteria), HttpStatus.OK);
    }

}
