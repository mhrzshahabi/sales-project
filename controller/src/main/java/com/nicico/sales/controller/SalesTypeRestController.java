package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.dto.SalesTypeDTO;
import com.nicico.sales.iservice.IInvoiceSalesService;
import com.nicico.sales.iservice.ISalesTypeService;
import com.nicico.sales.model.entities.base.SalesType;
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
@RequestMapping(value = "/api/salesType")

public class SalesTypeRestController {

    private final ISalesTypeService iSalesTypeService;

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<SalesTypeDTO.Info>> list() {
        return new ResponseEntity<>(iSalesTypeService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<SalesTypeDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iSalesTypeService.search(nicicoCriteria), HttpStatus.OK);
    }

}
