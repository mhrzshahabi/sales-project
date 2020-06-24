package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
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
@RequestMapping(value = "/api/contract-detail-type-param")
public class ContractDetailTypeParamRestController {

    private final IContractDetailTypeParamService contractDetailTypeParamService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailTypeParamDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailTypeParamService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailTypeParamDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailTypeParamService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailTypeParamDTO.Info> create(@Validated @RequestBody ContractDetailTypeParamDTO.Create request) {
        return new ResponseEntity<>(contractDetailTypeParamService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailTypeParamDTO.Info> update(@Validated @RequestBody ContractDetailTypeParamDTO.Update request) {

        return new ResponseEntity<>(contractDetailTypeParamService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailTypeParamService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailTypeParamDTO.Delete request) {

        contractDetailTypeParamService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailTypeParamDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailTypeParamService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/generatorDynamicForm/{id}")
    public ResponseEntity<List<ContractDetailTypeParamDTO.Info>> generatorDynamicForm(@PathVariable Long id) {
        return new ResponseEntity<>(contractDetailTypeParamService.findByContractDetailType(id), HttpStatus.OK);
    }

}
