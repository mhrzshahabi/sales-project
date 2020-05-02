package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermPartyDTO;
import com.nicico.sales.iservice.contract.IIncotermPartyService;
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
@RequestMapping(value = "/api/incoterm-party")
public class IncotermPartyRestController {

    private final IIncotermPartyService incotermPartyService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermPartyDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermPartyService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermPartyDTO.Info>> list() {

        return new ResponseEntity<>(incotermPartyService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermPartyDTO.Info> create(@Validated @RequestBody IncotermPartyDTO.Create request) {

        return new ResponseEntity<>(incotermPartyService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermPartyDTO.Info> update(@Validated @RequestBody IncotermPartyDTO.Update request) {

        return new ResponseEntity<>(incotermPartyService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermPartyService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermPartyDTO.Delete request) {

        incotermPartyService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermPartyDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermPartyService.search(nicicoCriteria), HttpStatus.OK);
    }
}
