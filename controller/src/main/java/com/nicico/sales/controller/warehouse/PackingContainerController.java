package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PackingContainerDTO;
import com.nicico.sales.iservice.contract.IPackingContainerService;
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
@RequestMapping(value = "/api/packing-container")
public class PackingContainerController {

    private final IPackingContainerService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<PackingContainerDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity(service.search(nicicoCriteria), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PackingContainerDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PackingContainerDTO.Info> create(@RequestBody PackingContainerDTO.Create request) {

        return new ResponseEntity<>(service.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        service.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping
    public ResponseEntity<HttpStatus> delete(@RequestBody PackingContainerDTO.Delete request) {
        service.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    @Loggable
    @PutMapping
    public ResponseEntity<PackingContainerDTO.Info> update(@Validated @RequestBody PackingContainerDTO.Update request) {

        return new ResponseEntity<>(service.update(request.getId(), request), HttpStatus.OK);
    }


}
