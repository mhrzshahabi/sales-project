package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseStockDTO;
import com.nicico.sales.iservice.IWarehouseStockService;
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
@RequestMapping(value = "/api/warehouseStock")
public class WarehouseStockRestController {

    private final IWarehouseStockService warehouseStockService;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseStockDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseStockService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseStockDTO.Info>> list() {
        return new ResponseEntity<>(warehouseStockService.list(), HttpStatus.OK);
    }

    /*@Loggable
    @PostMapping
    public ResponseEntity<WarehouseStockDTO.Info> create(@Validated @RequestBody WarehouseStockDTO.Create request) {
        return new ResponseEntity<>(warehouseStockService.create(request), HttpStatus.CREATED);
    }*/

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseStockDTO.Info> update(@RequestBody WarehouseStockDTO.Update request) {
        return new ResponseEntity<>(warehouseStockService.update(request.getId(), request), HttpStatus.OK);
    }

    /*@Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseStockService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }*/

    /*@Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseStockDTO.Delete request) {
        warehouseStockService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }*/

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseStockDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseStockService.search(nicicoCriteria), HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<WarehouseStockDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(warehouseStockService.search(request), HttpStatus.OK);
    }
}
