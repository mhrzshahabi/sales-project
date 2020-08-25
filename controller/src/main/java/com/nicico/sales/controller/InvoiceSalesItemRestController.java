package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceSalesItemDTO;
import com.nicico.sales.iservice.IInvoiceSalesItemService;
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
@RequestMapping(value = "/api/invoiceSalesItem")

public class InvoiceSalesItemRestController {

    private final IInvoiceSalesItemService iInvoiceSalesItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InvoiceSalesItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iInvoiceSalesItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceSalesItemDTO.Info>> list() {
        return new ResponseEntity<>(iInvoiceSalesItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InvoiceSalesItemDTO.Info> create(@Validated @RequestBody InvoiceSalesItemDTO.Create request) {
        return new ResponseEntity<>(iInvoiceSalesItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InvoiceSalesItemDTO.Info> update(@RequestBody InvoiceSalesItemDTO.Update request) {
        return new ResponseEntity<>(iInvoiceSalesItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iInvoiceSalesItemService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody InvoiceSalesItemDTO.Delete request) {
        iInvoiceSalesItemService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceSalesItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iInvoiceSalesItemService.search(nicicoCriteria), HttpStatus.OK);
    }
}
