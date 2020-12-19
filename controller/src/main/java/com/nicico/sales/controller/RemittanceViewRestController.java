package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.RemittanceViewDTO;
import com.nicico.sales.iservice.IRemittanceViewService;
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
@RequestMapping(value = "/api/remittance-view")

public class RemittanceViewRestController {

    private final IRemittanceViewService iRemittanceViewService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<RemittanceViewDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iRemittanceViewService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<RemittanceViewDTO.Info>> list() {
        return new ResponseEntity<>(iRemittanceViewService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<RemittanceViewDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iRemittanceViewService.search(nicicoCriteria), HttpStatus.OK);
    }


}
