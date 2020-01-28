package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.iservice.IInvoiceItemService;
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
@RequestMapping(value = "/api/invoiceItem")
public class InvoiceItemRestController {

    private final IInvoiceItemService invoiceItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InvoiceItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(invoiceItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceItemDTO.Info>> list() {
        return new ResponseEntity<>(invoiceItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InvoiceItemDTO.Info> create(@Validated @RequestBody InvoiceItemDTO.Create request) {
        return new ResponseEntity<>(invoiceItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InvoiceItemDTO.Info> update(@RequestBody InvoiceItemDTO.Update request) {
        return new ResponseEntity<>(invoiceItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        invoiceItemService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody InvoiceItemDTO.Delete request) {
        invoiceItemService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceItemService.search(nicicoCriteria), HttpStatus.OK);
    }
}
