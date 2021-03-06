package com.nicico.sales.controller.contract;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.DeductionDTO;
import com.nicico.sales.iservice.contract.IDeductionService;
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
@RequestMapping(value = "/api/deduction")
public class DeductionRestController {

    private final IDeductionService iDeductionService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<DeductionDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(iDeductionService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<DeductionDTO.Info>> list() {
        return new ResponseEntity<>(iDeductionService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<DeductionDTO.Info> create(@Validated @RequestBody DeductionDTO.Create request) {
        return new ResponseEntity<>(iDeductionService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<DeductionDTO.Info> update(@RequestBody DeductionDTO.Update request) {
        return new ResponseEntity<>(iDeductionService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        iDeductionService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody DeductionDTO.Delete request) {
        iDeductionService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<DeductionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(iDeductionService.search(nicicoCriteria), HttpStatus.OK);
    }

}
