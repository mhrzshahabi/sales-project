package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinSalesDTO;
import com.nicico.sales.iservice.ITozinSalesService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozinSales")
public class TozinSalesRestController {

    private final ITozinSalesService tozinSalesService;

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<TozinSalesDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinSalesService.search(nicicoCriteria), HttpStatus.OK);
    }
}
