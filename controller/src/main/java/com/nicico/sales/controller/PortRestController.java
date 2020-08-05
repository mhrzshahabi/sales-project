package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.iservice.IPortService;
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
@RequestMapping(value = "/api/port")
public class PortRestController {

    private final IPortService iPortService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<PortDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iPortService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PortDTO.Info>> list() {
        return new ResponseEntity<>(iPortService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PortDTO.Info> create(@Validated @RequestBody PortDTO.Create request) {
        return new ResponseEntity<>(iPortService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<PortDTO.Info> update(@RequestBody PortDTO.Update request) {
        return new ResponseEntity<>(iPortService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iPortService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PortDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iPortService.search(nicicoCriteria), HttpStatus.OK);
    }
}
