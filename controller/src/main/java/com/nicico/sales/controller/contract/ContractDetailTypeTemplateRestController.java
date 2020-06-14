package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
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
@RequestMapping(value = "/api/contract-detail-type-template")
public class ContractDetailTypeTemplateRestController {

    private final IContractDetailTypeTemplateService contractDetailTypeTemplateService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailTypeTemplateDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailTypeTemplateService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailTypeTemplateDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailTypeTemplateService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailTypeTemplateDTO.Info> create(@Validated @RequestBody ContractDetailTypeTemplateDTO.Create request) {

        return new ResponseEntity<>(contractDetailTypeTemplateService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailTypeTemplateDTO.Info> update(@Validated @RequestBody ContractDetailTypeTemplateDTO.Update request) {

        return new ResponseEntity<>(contractDetailTypeTemplateService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailTypeTemplateService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailTypeTemplateDTO.Delete request) {

        contractDetailTypeTemplateService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailTypeTemplateDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailTypeTemplateService.search(nicicoCriteria), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/generatorRichTextForm/{id}")
    public ResponseEntity<List<ContractDetailTypeTemplateDTO.Info>> generatorDynamicForm(@PathVariable Long id) {
        return new ResponseEntity<>(contractDetailTypeTemplateService.findByContractDetailType(id), HttpStatus.OK);
    }
}
