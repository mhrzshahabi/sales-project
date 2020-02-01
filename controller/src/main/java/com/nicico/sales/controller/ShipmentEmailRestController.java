package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentEmailDTO;
import com.nicico.sales.iservice.IShipmentEmailService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipmentEmail")
public class ShipmentEmailRestController {

    private final IShipmentEmailService shipmentEmailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentEmailDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentEmailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentEmailDTO.Info>> list() {
        return new ResponseEntity<>(shipmentEmailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentEmailDTO.Info> create(@Validated @RequestBody ShipmentEmailDTO.Create request) throws MessagingException {
        return new ResponseEntity<>(shipmentEmailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentEmailDTO.Info> update(@RequestBody ShipmentEmailDTO.Update request) {
        return new ResponseEntity<>(shipmentEmailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentEmailService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentEmailDTO.Delete request) {
        shipmentEmailService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentEmailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentEmailService.search(nicicoCriteria), HttpStatus.OK);
    }

}
