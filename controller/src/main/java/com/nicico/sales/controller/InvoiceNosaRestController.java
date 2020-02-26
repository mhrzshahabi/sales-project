package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.GridResponse;
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
    public ResponseEntity<TotalResponse<InvoiceNosaDTO.Info>> list() {

        GridResponse<InvoiceNosaDTO.Info> gridResponseInvoice = new GridResponse<>();
        gridResponseInvoice.setData(invoiceNosaService.list());
        gridResponseInvoice.setStartRow(0);
        gridResponseInvoice.setEndRow(gridResponseInvoice.getData().size());
        gridResponseInvoice.setTotalRows(gridResponseInvoice.getData().size());
        gridResponseInvoice.setStatus(0);
        gridResponseInvoice.setInvalidateCache(true);

        TotalResponse<InvoiceNosaDTO.Info> totalResponseInvoice = new TotalResponse<>(gridResponseInvoice);

        return new ResponseEntity<>(totalResponseInvoice, HttpStatus.OK);
    }
}
