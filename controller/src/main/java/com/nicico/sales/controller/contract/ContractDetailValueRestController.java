package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailValueDTO;
import com.nicico.sales.iservice.contract.IContractDetailValueService;
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
@RequestMapping(value = "/api/contract-detail-value")
public class ContractDetailValueRestController {

    private final IContractDetailValueService contractDetailValueService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailValueDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailValueService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailValueDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailValueService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailValueDTO.Info> create(@Validated @RequestBody ContractDetailValueDTO.Create request) {

        return new ResponseEntity<>(contractDetailValueService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailValueDTO.Info> update(@Validated @RequestBody ContractDetailValueDTO.Update request) {

        return new ResponseEntity<>(contractDetailValueService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailValueService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailValueDTO.Delete request) {

        contractDetailValueService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailValueDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailValueService.search(nicicoCriteria), HttpStatus.OK);
    }
}
