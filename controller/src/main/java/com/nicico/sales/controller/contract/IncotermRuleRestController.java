package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermRuleDTO;
import com.nicico.sales.iservice.contract.IIncotermRuleService;
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
@RequestMapping(value = "/api/incoterm-rule")
public class IncotermRuleRestController {

    private final IIncotermRuleService incotermRuleService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermRuleDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermRuleService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermRuleDTO.Info>> list() {

        return new ResponseEntity<>(incotermRuleService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermRuleDTO.Info> create(@Validated @RequestBody IncotermRuleDTO.Create request) {

        return new ResponseEntity<>(incotermRuleService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermRuleDTO.Info> update(@RequestBody IncotermRuleDTO.Update request) {

        return new ResponseEntity<>(incotermRuleService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermRuleService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermRuleDTO.Delete request) {

        incotermRuleService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermRuleDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermRuleService.search(nicicoCriteria), HttpStatus.OK);
    }
}
