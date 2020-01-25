package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.LMEDTO;
import com.nicico.sales.iservice.ILMEService;
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
@RequestMapping(value = "/api/LME")
public class LMERestController {

    private final ILMEService lMEService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<LMEDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(lMEService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<LMEDTO.Info>> list() {
        return new ResponseEntity<>(lMEService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<LMEDTO.Info> create(@Validated @RequestBody LMEDTO.Create request) {
        return new ResponseEntity<>(lMEService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<LMEDTO.Info> update(@RequestBody LMEDTO.Update request) {
        return new ResponseEntity<>(lMEService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        lMEService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody LMEDTO.Delete request) {
        lMEService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<LMEDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(lMEService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<LMEDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(lMEService.search(request), HttpStatus.OK);
    }
}
