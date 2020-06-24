package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.iservice.IRemittanceDetailService;
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
@RequestMapping(value = "/api/remittanceDetail")

public class RemittanceDetailRestController {

    private final IRemittanceDetailService iRemittanceDetailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<RemittanceDetailDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iRemittanceDetailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<RemittanceDetailDTO.Info>> list() {
        return new ResponseEntity<>(iRemittanceDetailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<RemittanceDetailDTO.Info> create(@Validated @RequestBody RemittanceDetailDTO.Create request) {
        return new ResponseEntity<>(iRemittanceDetailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<RemittanceDetailDTO.Info> update(@RequestBody RemittanceDetailDTO.Update request) {
        return new ResponseEntity<>(iRemittanceDetailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        iRemittanceDetailService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<RemittanceDetailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iRemittanceDetailService.search(nicicoCriteria), HttpStatus.OK);
    }
}