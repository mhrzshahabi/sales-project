package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.VesselDTO;
import com.nicico.sales.iservice.IVesselService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/vessel")

public class VesselRestController {

    private final IVesselService iVesselService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<VesselDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iVesselService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<VesselDTO.Info>> list() {
        return new ResponseEntity<>(iVesselService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<VesselDTO.Info> create(@Validated @RequestBody VesselDTO.Create request) {
        return new ResponseEntity<>(iVesselService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<VesselDTO.Info> update(@RequestBody VesselDTO.Update request) {
        return new ResponseEntity<>(iVesselService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iVesselService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody VesselDTO.Delete request) {
        iVesselService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<VesselDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iVesselService.search(nicicoCriteria), HttpStatus.OK);
    }
}
