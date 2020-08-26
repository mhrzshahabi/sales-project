package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.iservice.IInvoiceSalesService;
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
@RequestMapping(value = "/api/invoiceSales")

public class InvoiceSalesRestController {

    private final IInvoiceSalesService invoiceSalesService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InvoiceSalesDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(invoiceSalesService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceSalesDTO.Info>> list() {
        return new ResponseEntity<>(invoiceSalesService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InvoiceSalesDTO.Info> create(@Validated @RequestBody InvoiceSalesDTO.Create request) {
        return new ResponseEntity<>(invoiceSalesService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InvoiceSalesDTO.Info> update(@RequestBody InvoiceSalesDTO.Update request) {
        return new ResponseEntity<>(invoiceSalesService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        invoiceSalesService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody InvoiceSalesDTO.Delete request) {
        invoiceSalesService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceSalesDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceSalesService.search(nicicoCriteria), HttpStatus.OK);
    }
}
