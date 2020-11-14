package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PackingListDTO;
import com.nicico.sales.iservice.contract.IPackingListService;
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
@RequestMapping(value = "/api/packing-list")
public class PackingListRestController {

    private final IPackingListService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<PackingListDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PackingListDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PackingListDTO.Info> create(@RequestBody PackingListDTO.Create request) {

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
    public ResponseEntity<HttpStatus> delete(@RequestBody PackingListDTO.Delete request) {
        service.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    @Loggable
    @PutMapping
    public ResponseEntity<PackingListDTO.Info> update(@Validated @RequestBody PackingListDTO.Update request) {

        return new ResponseEntity<>(service.update(request.getId(), request), HttpStatus.OK);
    }


}
