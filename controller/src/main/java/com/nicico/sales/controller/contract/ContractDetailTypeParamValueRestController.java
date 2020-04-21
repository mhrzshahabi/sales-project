package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailTypeParamValueDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamValueService;
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
@RequestMapping(value = "/api/contract-detail-type-param-value")
public class ContractDetailTypeParamValueRestController {

    private final IContractDetailTypeParamValueService contractDetailTypeParamValueService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailTypeParamValueDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailTypeParamValueService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailTypeParamValueDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailTypeParamValueService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailTypeParamValueDTO.Info> create(@Validated @RequestBody ContractDetailTypeParamValueDTO.Create request) {

        return new ResponseEntity<>(contractDetailTypeParamValueService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailTypeParamValueDTO.Info> update(@RequestBody ContractDetailTypeParamValueDTO.Update request) {

        return new ResponseEntity<>(contractDetailTypeParamValueService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailTypeParamValueService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailTypeParamValueDTO.Delete request) {

        contractDetailTypeParamValueService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailTypeParamValueDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailTypeParamValueService.search(nicicoCriteria), HttpStatus.OK);
    }
}
