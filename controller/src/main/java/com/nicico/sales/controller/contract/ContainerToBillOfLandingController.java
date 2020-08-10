package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContainerToBillOfLandingDTO;
import com.nicico.sales.iservice.contract.IContainerToBillOfLandingService;
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
@RequestMapping(value = "/api/container-to-bill-of-landing")
public class ContainerToBillOfLandingController {

    private final IContainerToBillOfLandingService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<ContainerToBillOfLandingDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContainerToBillOfLandingDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }


    @Loggable
    @PostMapping
    public ResponseEntity<ContainerToBillOfLandingDTO.Info> create(@Validated @RequestBody ContainerToBillOfLandingDTO.Create request) {
        return new ResponseEntity<>(service.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContainerToBillOfLandingDTO.Info> update(@Validated @RequestBody ContainerToBillOfLandingDTO.Update request) {
        return new ResponseEntity<>(service.update(request), HttpStatus.CREATED);
    }

    @Loggable
    @DeleteMapping
    public ResponseEntity<HttpStatus> delete(@Validated @RequestBody ContainerToBillOfLandingDTO.Delete request) {
        service.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }


}
