package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.iservice.IPriceBaseService;
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
@RequestMapping(value = "/api/price-base")

public class PriceBaseRestController {

    private final IPriceBaseService iPriceBaseService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<PriceBaseDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iPriceBaseService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PriceBaseDTO.Info>> list() {
        return new ResponseEntity<>(iPriceBaseService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PriceBaseDTO.Info> create(@Validated @RequestBody PriceBaseDTO.Create request) {
        return new ResponseEntity<>(iPriceBaseService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<PriceBaseDTO.Info> update(@RequestBody PriceBaseDTO.Update request) {
        return new ResponseEntity<>(iPriceBaseService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iPriceBaseService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PriceBaseDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iPriceBaseService.search(nicicoCriteria), HttpStatus.OK);
    }
}
