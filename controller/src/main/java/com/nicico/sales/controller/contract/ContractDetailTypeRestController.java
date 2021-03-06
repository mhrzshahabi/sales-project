package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
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
@RequestMapping(value = "/api/contract-detail-type")
public class ContractDetailTypeRestController {

    private final IContractDetailTypeService contractDetailTypeService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailTypeDTO.InfoWithoutDetail> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailTypeService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailTypeDTO.InfoWithoutDetail>> list() {

        return new ResponseEntity<>(contractDetailTypeService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailTypeDTO.InfoWithoutDetail> create(@Validated @RequestBody ContractDetailTypeDTO.Create request) {

        return new ResponseEntity<>(contractDetailTypeService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailTypeDTO.InfoWithoutDetail> update(@Validated @RequestBody ContractDetailTypeDTO.Update request) {

        return new ResponseEntity<>(contractDetailTypeService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailTypeService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailTypeDTO.Delete request) {

        contractDetailTypeService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailTypeDTO.InfoWithoutDetail>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailTypeService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list-contract")
    public ResponseEntity<TotalResponse<ContractDetailTypeDTO.Info>> completeList(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailTypeService.completeSearch(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/activate/{id}")
    public ResponseEntity<ContractDetailTypeDTO.InfoWithoutDetail> activate(@PathVariable Long id) {
        return new ResponseEntity<>(contractDetailTypeService.activate(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/deactivate/{id}")
    public ResponseEntity<ContractDetailTypeDTO.InfoWithoutDetail> deactivate(@PathVariable Long id) {
        return new ResponseEntity<>(contractDetailTypeService.deactivate(id), HttpStatus.OK);
    }


}
