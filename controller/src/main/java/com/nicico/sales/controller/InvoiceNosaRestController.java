package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.iservice.IInvoiceNosaService;
import com.nicico.sales.iservice.IInvoiceSalesService;
import com.nicico.sales.model.entities.base.InvoiceNosa;
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
@RequestMapping(value = "/api/invoiceNosaSales")

public class InvoiceNosaRestController {

    private final IInvoiceNosaService invoiceNosaService;

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceNosaDTO.Info>> list() {
//        System.out.println("@@@@@" + invoiceNosaService.list().get(0).getCode());
//        System.out.println("&&&&" + invoiceNosaService.list().get(1).getCode());
        return new ResponseEntity<>(invoiceNosaService.list(), HttpStatus.OK);
    }

}
