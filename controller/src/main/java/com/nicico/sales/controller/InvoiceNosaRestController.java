package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.iservice.IInvoiceNosaService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/invoiceNosaSales")

public class InvoiceNosaRestController {

    private final IInvoiceNosaService invoiceNosaService;

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceNosaDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceNosaService.search(nicicoCriteria), HttpStatus.OK);
    }
}
