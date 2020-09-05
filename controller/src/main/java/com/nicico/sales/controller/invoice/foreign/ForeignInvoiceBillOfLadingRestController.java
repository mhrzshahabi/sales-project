package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceBillOfLandingDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceBillOfLadingService;
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
@RequestMapping(value = "/api/foreign-invoice-bill-of-lading")
public class ForeignInvoiceBillOfLadingRestController {

    private final IForeignInvoiceBillOfLadingService foreignInvoiceBillOfLadingService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoiceBillOfLandingDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceBillOfLadingService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoiceBillOfLandingDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoiceBillOfLadingService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoiceBillOfLandingDTO.Info> create(@Validated @RequestBody ForeignInvoiceBillOfLandingDTO.Create request) {

        return new ResponseEntity<>(foreignInvoiceBillOfLadingService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoiceBillOfLandingDTO.Info> update(@Validated @RequestBody ForeignInvoiceBillOfLandingDTO.Update request) {

        return new ResponseEntity<>(foreignInvoiceBillOfLadingService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoiceBillOfLadingService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoiceBillOfLandingDTO.Delete request) {

        foreignInvoiceBillOfLadingService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoiceBillOfLandingDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoiceBillOfLadingService.search(nicicoCriteria), HttpStatus.OK);
    }
}
