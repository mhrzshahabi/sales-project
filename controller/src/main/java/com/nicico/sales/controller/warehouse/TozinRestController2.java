package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.iservice.warehous.ITozinService2;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozin2")
public class TozinRestController2 {

    private final ITozinService2 tozinService;


    @Loggable
    @GetMapping(value = {"/on-way-product/spec-list"})

    public ResponseEntity<TotalResponse<TozinTable>> searchOnWayProduct(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = {"/search-tozin"})
    public ResponseEntity<TotalResponse<TozinTable>> searchTozinComboBijack(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinService.search(nicicoCriteria), HttpStatus.OK);
    }


}
