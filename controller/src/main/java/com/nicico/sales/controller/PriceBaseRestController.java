package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.iservice.IPriceBaseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/price-base")

public class PriceBaseRestController {

    private final IPriceBaseService priceBaseService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<PriceBaseDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(priceBaseService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PriceBaseDTO.Info>> list() {
        return new ResponseEntity<>(priceBaseService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PriceBaseDTO.Info> create(@Validated @RequestBody PriceBaseDTO.Create request) {
        return new ResponseEntity<>(priceBaseService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<PriceBaseDTO.Info> update(@RequestBody PriceBaseDTO.Update request) {
        return new ResponseEntity<>(priceBaseService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        priceBaseService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PriceBaseDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(priceBaseService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-avg-base-price")
    public ResponseEntity<List<PriceBaseDTO.Info>> getBasePrice(@RequestParam("contractId") Long contractId, @RequestParam("financeUnitId") Long financeUnitId, @RequestParam("sendDate") @DateTimeFormat(pattern = "MM/dd/yyyy") Date sendDate) {
        return new ResponseEntity<>(priceBaseService.getAverageOfElementBasePrices(contractId, financeUnitId, sendDate), HttpStatus.OK);
    }
}
