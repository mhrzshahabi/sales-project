package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PercentPerYearDTO;
import com.nicico.sales.iservice.IPercentPerYearService;
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
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/percentPerYear")

public class PercentPerYearRestController {

    private final IPercentPerYearService iPercentPerYearService;

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PercentPerYearDTO.Info>> list() {
        return new ResponseEntity<>(iPercentPerYearService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PercentPerYearDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iPercentPerYearService.search(nicicoCriteria), HttpStatus.OK);
    }

}
