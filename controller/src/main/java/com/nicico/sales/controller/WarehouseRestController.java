package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseDTO;
import com.nicico.sales.iservice.IWarehouseService2;
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
@RequestMapping(value = "/api/warehouse")
public class WarehouseRestController {

    private final IWarehouseService2 warehouseService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseService.get(id), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseDTO.Info>> list() {
        return new ResponseEntity<>(warehouseService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<WarehouseDTO.Info>> updateFromTozinView() {
        warehouseService.updateFromTozinView();
        return new ResponseEntity<>(warehouseService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseService.search(nicicoCriteria), HttpStatus.OK);
    }

}
