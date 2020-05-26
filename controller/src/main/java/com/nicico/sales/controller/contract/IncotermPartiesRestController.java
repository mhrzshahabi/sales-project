package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermPartiesDTO;
import com.nicico.sales.iservice.contract.IIncotermPartiesService;
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
@RequestMapping(value = "/api/incoterm-parties")
public class IncotermPartiesRestController {

    private final IIncotermPartiesService incotermPartiesService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermPartiesDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermPartiesService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermPartiesDTO.Info>> list() {

        return new ResponseEntity<>(incotermPartiesService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermPartiesDTO.Info> create(@Validated @RequestBody IncotermPartiesDTO.Create request) {

        return new ResponseEntity<>(incotermPartiesService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermPartiesDTO.Info> update(@Validated @RequestBody IncotermPartiesDTO.Update request) {

        return new ResponseEntity<>(incotermPartiesService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermPartiesService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermPartiesDTO.Delete request) {

        incotermPartiesService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermPartiesDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermPartiesService.search(nicicoCriteria), HttpStatus.OK);
    }
}
