package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDetailDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemDetailService;
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
@RequestMapping(value = "/api/foreign-invoice-item-detail")
public class ForeignInvoiceItemDetailRestController {

    private final IForeignInvoiceItemDetailService foreignInvoiceItemDetailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoiceItemDetailDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceItemDetailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoiceItemDetailDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoiceItemDetailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoiceItemDetailDTO.Info> create(@Validated @RequestBody ForeignInvoiceItemDetailDTO.Create request) {

        return new ResponseEntity<>(foreignInvoiceItemDetailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoiceItemDetailDTO.Info> update(@Validated @RequestBody ForeignInvoiceItemDetailDTO.Update request) {

        return new ResponseEntity<>(foreignInvoiceItemDetailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoiceItemDetailService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoiceItemDetailDTO.Delete request) {

        foreignInvoiceItemDetailService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoiceItemDetailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoiceItemDetailService.search(nicicoCriteria), HttpStatus.OK);
    }
}
