package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.iservice.contract.IContractDetailService;
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
@RequestMapping(value = "/api/g-contract-detail")
public class ContractDetailRestController {

    private final IContractDetailService contractDetailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDetailDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractDetailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDetailDTO.Info>> list() {

        return new ResponseEntity<>(contractDetailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDetailDTO.Info> create(@Validated @RequestBody ContractDetailDTO.Create request) {

        return new ResponseEntity<>(contractDetailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDetailDTO.Info> update(@Validated @RequestBody ContractDetailDTO.Update request) {

        return new ResponseEntity<>(contractDetailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractDetailService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDetailDTO.Delete request) {

        contractDetailService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDetailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractDetailService.search(nicicoCriteria), HttpStatus.OK);
    }
}
