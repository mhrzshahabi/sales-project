package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/api/foreign-invoice")
public class ForeignInvoiceRestController {

    private final IForeignInvoiceService foreignInvoiceService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoiceDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoiceService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoiceDTO.Info> create(@Validated @RequestBody ForeignInvoiceDTO.Create request) {

        return new ResponseEntity<>(foreignInvoiceService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoiceDTO.Info> update(@Validated @RequestBody ForeignInvoiceDTO.Update request) {

        return new ResponseEntity<>(foreignInvoiceService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoiceService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoiceDTO.Delete request) {

        foreignInvoiceService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-by-contract")
    public ResponseEntity<List<ForeignInvoiceDTO.Info>> getByContract(@RequestParam Long invoiceTypeId, @RequestParam Long contractId, @RequestParam Long currencyId) {

        return new ResponseEntity<>(foreignInvoiceService.getByContract(invoiceTypeId, contractId, currencyId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoiceDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoiceService.search(nicicoCriteria), HttpStatus.OK);
    }
}
