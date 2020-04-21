package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermAspectDTO;
import com.nicico.sales.iservice.contract.IIncotermAspectService;
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
@RequestMapping(value = "/api/incoterm-aspect-aspect")
public class IncotermAspectRestController {

    private final IIncotermAspectService incotermAspectService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermAspectDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermAspectService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermAspectDTO.Info>> list() {

        return new ResponseEntity<>(incotermAspectService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermAspectDTO.Info> create(@Validated @RequestBody IncotermAspectDTO.Create request) {

        return new ResponseEntity<>(incotermAspectService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermAspectDTO.Info> update(@RequestBody IncotermAspectDTO.Update request) {

        return new ResponseEntity<>(incotermAspectService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermAspectService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermAspectDTO.Delete request) {

        incotermAspectService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermAspectDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermAspectService.search(nicicoCriteria), HttpStatus.OK);
    }
}
