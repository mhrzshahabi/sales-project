package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermStepsDTO;
import com.nicico.sales.iservice.contract.IIncotermStepsService;
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
@RequestMapping(value = "/api/incoterm-Steps")
public class IncotermStepsRestController {

    private final IIncotermStepsService incotermStepsService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermStepsDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermStepsService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermStepsDTO.Info>> list() {

        return new ResponseEntity<>(incotermStepsService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermStepsDTO.Info> create(@Validated @RequestBody IncotermStepsDTO.Create request) {

        return new ResponseEntity<>(incotermStepsService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermStepsDTO.Info> update(@Validated @RequestBody IncotermStepsDTO.Update request) {

        return new ResponseEntity<>(incotermStepsService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermStepsService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermStepsDTO.Delete request) {

        incotermStepsService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermStepsDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermStepsService.search(nicicoCriteria), HttpStatus.OK);
    }
}
