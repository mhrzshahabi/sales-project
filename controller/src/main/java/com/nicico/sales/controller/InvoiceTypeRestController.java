package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.iservice.IInvoiceTypeService;
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
@RequestMapping(value = "/api/invoicetype")
public class InvoiceTypeRestController {

    private final IInvoiceTypeService iInvoiceTypeService;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InvoiceTypeDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iInvoiceTypeService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceTypeDTO.Info>> list() {
        return new ResponseEntity<>(iInvoiceTypeService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InvoiceTypeDTO.Info> create(@Validated @RequestBody InvoiceTypeDTO.Create request) {
        return new ResponseEntity<>(iInvoiceTypeService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InvoiceTypeDTO.Info> update(@RequestBody InvoiceTypeDTO.Update request) {
        return new ResponseEntity<>(iInvoiceTypeService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iInvoiceTypeService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<HttpStatus> delete(@Validated @RequestBody InvoiceTypeDTO.Delete request) {
        iInvoiceTypeService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceTypeDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iInvoiceTypeService.search(nicicoCriteria), HttpStatus.OK);
    }

}
