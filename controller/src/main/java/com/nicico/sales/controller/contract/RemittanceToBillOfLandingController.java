package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.RemittanceToBillOfLandingDTO;
import com.nicico.sales.iservice.contract.IRemittanceToBillOfLandingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/remittance-to-bill-of-landing")
public class RemittanceToBillOfLandingController {

    private final IRemittanceToBillOfLandingService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<RemittanceToBillOfLandingDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<List<RemittanceToBillOfLandingDTO.Info>> create(@Validated @RequestBody List<RemittanceToBillOfLandingDTO.Create> request) {
        return new ResponseEntity<>(service.batch(request), HttpStatus.CREATED);
    }

    @Loggable
    @DeleteMapping
    public ResponseEntity delete(@Validated @RequestBody RemittanceToBillOfLandingDTO.Delete request) {
        service.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<RemittanceToBillOfLandingDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }


}
