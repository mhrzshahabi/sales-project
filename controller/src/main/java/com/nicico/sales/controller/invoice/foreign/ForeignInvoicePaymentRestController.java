package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoicePaymentDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoicePaymentService;
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
@RequestMapping(value = "/api/foreign-invoice-payment")
public class ForeignInvoicePaymentRestController {

    private final IForeignInvoicePaymentService foreignInvoicePaymentService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoicePaymentDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoicePaymentService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoicePaymentDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoicePaymentService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoicePaymentDTO.Info> create(@Validated @RequestBody ForeignInvoicePaymentDTO.Create request) {

        return new ResponseEntity<>(foreignInvoicePaymentService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoicePaymentDTO.Info> update(@Validated @RequestBody ForeignInvoicePaymentDTO.Update request) {

        return new ResponseEntity<>(foreignInvoicePaymentService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoicePaymentService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoicePaymentDTO.Delete request) {

        foreignInvoicePaymentService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoicePaymentDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoicePaymentService.search(nicicoCriteria), HttpStatus.OK);
    }
}
