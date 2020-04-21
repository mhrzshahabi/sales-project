package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractTypeDTO;
import com.nicico.sales.iservice.contract.IContractTypeService;
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
@RequestMapping(value = "/api/contract-type")
public class ContractTypeRestController {

    private final IContractTypeService contractTypeService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractTypeDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractTypeService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractTypeDTO.Info>> list() {

        return new ResponseEntity<>(contractTypeService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractTypeDTO.Info> create(@Validated @RequestBody ContractTypeDTO.Create request) {

        return new ResponseEntity<>(contractTypeService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractTypeDTO.Info> update(@RequestBody ContractTypeDTO.Update request) {

        return new ResponseEntity<>(contractTypeService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractTypeService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractTypeDTO.Delete request) {

        contractTypeService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractTypeDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractTypeService.search(nicicoCriteria), HttpStatus.OK);
    }
}
