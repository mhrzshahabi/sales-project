package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.iservice.IinventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/api/inventory")
public class InventoryRestController {

    private final IinventoryService iinventoryService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InventoryDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(iinventoryService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InventoryDTO.Info>> list() {

        return new ResponseEntity<>(iinventoryService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InventoryDTO.Info> create(@Validated @RequestBody InventoryDTO.Create request) {

        return new ResponseEntity<>(iinventoryService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InventoryDTO.Info> update(@Validated @RequestBody InventoryDTO.Update request) {

        return new ResponseEntity<>(iinventoryService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        iinventoryService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody InventoryDTO.Delete request) {

        iinventoryService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InventoryDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iinventoryService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-all-inventories-by-warehouse")
    public ResponseEntity<TotalResponse<InventoryDTO.Info>> getAllInventoriesByWarehouse(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iinventoryService.getAllInventoriesByWarehouse(nicicoCriteria), HttpStatus.OK);
    }
}
