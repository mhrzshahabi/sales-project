package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GlossaryDTO;
import com.nicico.sales.iservice.IGlossaryService;
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
@RequestMapping(value = "/api/glossary")
public class GlossaryRestController {

    private final IGlossaryService glossaryService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<GlossaryDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(glossaryService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<GlossaryDTO.Info>> list() {
        return new ResponseEntity<>(glossaryService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<GlossaryDTO.Info> create(@Validated @RequestBody GlossaryDTO.Create request) {
        return new ResponseEntity<>(glossaryService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<GlossaryDTO.Info> update(@RequestBody GlossaryDTO.Update request) {
        return new ResponseEntity<>(glossaryService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        glossaryService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody GlossaryDTO.Delete request) {
        glossaryService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<GlossaryDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(glossaryService.search(nicicoCriteria), HttpStatus.OK);
    }
}
