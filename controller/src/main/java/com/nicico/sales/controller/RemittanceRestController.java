package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.iservice.IRemittanceService;
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
@RequestMapping(value = "/api/remittance")

public class RemittanceRestController {

    private final IRemittanceService iRemittanceService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<RemittanceDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iRemittanceService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<RemittanceDTO.Info>> list() {
        return new ResponseEntity<>(iRemittanceService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<RemittanceDTO.Info> create(@Validated @RequestBody RemittanceDTO.Create request) {
        return new ResponseEntity<>(iRemittanceService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<RemittanceDTO.Info> update(@RequestBody RemittanceDTO.Update request) {
        return new ResponseEntity<>(iRemittanceService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iRemittanceService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/prune")
    public ResponseEntity delete(@RequestBody RemittanceDTO.Delete ids) {
        iRemittanceService.deleteAll(ids);
        return new ResponseEntity(HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<RemittanceDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iRemittanceService.search(nicicoCriteria), HttpStatus.OK);
    }
}
