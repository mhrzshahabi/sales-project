package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermRulesDTO;
import com.nicico.sales.iservice.contract.IIncotermRulesService;
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
@RequestMapping(value = "/api/incoterm-rules")
public class IncotermRulesRestController {

    private final IIncotermRulesService incotermRulesService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermRulesDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermRulesService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermRulesDTO.Info>> list() {

        return new ResponseEntity<>(incotermRulesService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermRulesDTO.Info> create(@Validated @RequestBody IncotermRulesDTO.Create request) {

        return new ResponseEntity<>(incotermRulesService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermRulesDTO.Info> update(@RequestBody IncotermRulesDTO.Update request) {

        return new ResponseEntity<>(incotermRulesService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermRulesService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermRulesDTO.Delete request) {

        incotermRulesService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermRulesDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermRulesService.search(nicicoCriteria), HttpStatus.OK);
    }
}
