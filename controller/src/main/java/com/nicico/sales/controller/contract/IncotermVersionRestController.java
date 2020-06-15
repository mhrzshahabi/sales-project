package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermVersionDTO;
import com.nicico.sales.iservice.contract.IIncotermVersionService;
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
@RequestMapping(value = "/api/incoterm-version")
public class IncotermVersionRestController {

    private final IIncotermVersionService incotermVersionService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermVersionDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermVersionService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermVersionDTO.Info>> list() {

        return new ResponseEntity<>(incotermVersionService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermVersionDTO.Info> create(@Validated @RequestBody IncotermVersionDTO.Create request) {

        return new ResponseEntity<>(incotermVersionService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermVersionDTO.Info> update(@Validated @RequestBody IncotermVersionDTO.Update request) {

        return new ResponseEntity<>(incotermVersionService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermVersionService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermVersionDTO.Delete request) {

        incotermVersionService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermVersionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermVersionService.search(nicicoCriteria), HttpStatus.OK);
    }
}
