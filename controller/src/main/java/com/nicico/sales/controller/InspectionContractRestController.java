package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.iservice.IInspectionContractService;
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
@RequestMapping(value = "/api/inspectionContract")
public class InspectionContractRestController {

    private final IInspectionContractService inspectionContractService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InspectionContractDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(inspectionContractService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InspectionContractDTO.Info>> list() {
        return new ResponseEntity<>(inspectionContractService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<InspectionContractDTO.Info> create(@Validated @RequestBody InspectionContractDTO.Create request) {
        return new ResponseEntity<>(inspectionContractService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<InspectionContractDTO.Info> update(@RequestBody InspectionContractDTO.Update request) {
        return new ResponseEntity<>(inspectionContractService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        inspectionContractService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody InspectionContractDTO.Delete request) {
        inspectionContractService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InspectionContractDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        TotalResponse<InspectionContractDTO.Info> search = inspectionContractService.search(criteria);
        return new ResponseEntity<TotalResponse<InspectionContractDTO.Info>>(search, HttpStatus.OK);
    }
}
