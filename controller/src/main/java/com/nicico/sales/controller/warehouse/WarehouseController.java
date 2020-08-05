package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseDTO;
import com.nicico.sales.iservice.warehous.IWarehouseService;
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
@RequestMapping(value = "/api/warehouse")
public class WarehouseController {

    private final IWarehouseService service;


    @Loggable
    @GetMapping(value = {"/spec-list"})

    public ResponseEntity<TotalResponse<WarehouseDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<WarehouseDTO.Info>> updateFromTozinView() {
        service.updateFromTozinView();
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }


}
