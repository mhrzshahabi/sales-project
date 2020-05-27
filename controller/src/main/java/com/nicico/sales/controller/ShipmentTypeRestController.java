package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentTypeDTO;
import com.nicico.sales.iservice.IShipmentTypeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.IOException;
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipmenttype")
public class ShipmentTypeRestController {

    private final IShipmentTypeService iShipmentTypeService;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentTypeDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iShipmentTypeService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentTypeDTO.Info>> list() {
        return new ResponseEntity<>(iShipmentTypeService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentTypeDTO.Info> create(@Validated @RequestBody ShipmentTypeDTO.Create request) {
        return new ResponseEntity<>(iShipmentTypeService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentTypeDTO.Info> update(@RequestBody ShipmentTypeDTO.Update request) {
        return new ResponseEntity<>(iShipmentTypeService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iShipmentTypeService.delete(id);
        return new ResponseEntity<Void>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentTypeDTO.Delete request) {
        iShipmentTypeService.deleteAll(request);
        return new ResponseEntity<Void>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentTypeDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iShipmentTypeService.search(nicicoCriteria), HttpStatus.OK);
    }

}
