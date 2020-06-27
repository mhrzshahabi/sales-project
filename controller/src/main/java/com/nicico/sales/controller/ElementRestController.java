package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ElementDTO;
import com.nicico.sales.iservice.IElementService;
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
@RequestMapping(value = "/api/element")

public class ElementRestController {

    private final IElementService iElementService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ElementDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iElementService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ElementDTO.Info>> list() {
        return new ResponseEntity<>(iElementService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ElementDTO.Info> create(@Validated @RequestBody ElementDTO.Create request) {
        return new ResponseEntity<>(iElementService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ElementDTO.Info> update(@RequestBody ElementDTO.Update request) {
        return new ResponseEntity<>(iElementService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iElementService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ElementDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iElementService.search(nicicoCriteria), HttpStatus.OK);
    }
}
