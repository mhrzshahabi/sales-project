package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.iservice.contract.IBillOfLandingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/bill-of-landing")
public class BillOfLandingController {

    private final IBillOfLandingService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<BillOfLandingDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }



    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<BillOfLandingDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }


}
