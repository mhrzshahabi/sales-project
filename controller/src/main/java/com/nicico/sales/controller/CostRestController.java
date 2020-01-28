package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CostDTO;
import com.nicico.sales.iservice.ICostService;
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
@RequestMapping(value = "/api/cost")
public class CostRestController {

    private final ICostService costService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<CostDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(costService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<CostDTO.Info>> list() {
        return new ResponseEntity<>(costService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<CostDTO.Info> create(@Validated @RequestBody CostDTO.Create request) {
        return new ResponseEntity<>(costService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<CostDTO.Info> update(@RequestBody CostDTO.Update request) {
        return new ResponseEntity<>(costService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        costService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody CostDTO.Delete request) {
        costService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<CostDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(costService.search(nicicoCriteria), HttpStatus.OK);
    }
}
