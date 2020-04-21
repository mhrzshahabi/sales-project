package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.iservice.contract.IIncotermService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/g-incoterm")
public class IncotermRestController {

    private final IIncotermService incotermService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermDTO.Info>> list() {

        return new ResponseEntity<>(incotermService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermDTO.Info> create(@Validated @RequestBody IncotermDTO.Create request) {

        return new ResponseEntity<>(incotermService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermDTO.Info> update(@RequestBody IncotermDTO.Update request) {

        return new ResponseEntity<>(incotermService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermDTO.Delete request) {

        incotermService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermService.search(nicicoCriteria), HttpStatus.OK);
    }
}
