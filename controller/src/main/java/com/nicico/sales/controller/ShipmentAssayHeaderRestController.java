package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentAssayHeaderDTO;
import com.nicico.sales.iservice.IShipmentAssayHeaderService;
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
@RequestMapping(value = "/api/shipmentAssayHeader")
public class ShipmentAssayHeaderRestController {

    private final IShipmentAssayHeaderService shipmentAssayHeaderService;

    @Loggable
    @GetMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('r_shipmentAssayHeader')")
    public ResponseEntity<ShipmentAssayHeaderDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentAssayHeaderService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('r_shipmentAssayHeader')")
    public ResponseEntity<List<ShipmentAssayHeaderDTO.Info>> list() {
        return new ResponseEntity<>(shipmentAssayHeaderService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    //	@PreAuthorize("hasAuthority('c_shipmentAssayHeader')")
    public ResponseEntity<ShipmentAssayHeaderDTO.Info> create(@Validated @RequestBody ShipmentAssayHeaderDTO.Create request) {
        return new ResponseEntity<>(shipmentAssayHeaderService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    //	@PreAuthorize("hasAuthority('u_shipmentAssayHeader')")
    public ResponseEntity<ShipmentAssayHeaderDTO.Info> update(@RequestBody ShipmentAssayHeaderDTO.Update request) {
        return new ResponseEntity<>(shipmentAssayHeaderService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('d_shipmentAssayHeader')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentAssayHeaderService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('d_shipmentAssayHeader')")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentAssayHeaderDTO.Delete request) {
        shipmentAssayHeaderService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
    public ResponseEntity<TotalResponse<ShipmentAssayHeaderDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentAssayHeaderService.search(nicicoCriteria), HttpStatus.OK);
    }


}
