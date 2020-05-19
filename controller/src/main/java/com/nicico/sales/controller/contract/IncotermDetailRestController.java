package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.IncotermDetailDTO;
import com.nicico.sales.iservice.contract.IIncotermDetailService;
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
@RequestMapping(value = "/api/incoterm-detail")
public class IncotermDetailRestController {

    private final IIncotermDetailService incotermDetailService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<IncotermDetailDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(incotermDetailService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<IncotermDetailDTO.Info>> list() {

        return new ResponseEntity<>(incotermDetailService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<IncotermDetailDTO.Info> create(@Validated @RequestBody IncotermDetailDTO.Create request) {

        return new ResponseEntity<>(incotermDetailService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<IncotermDetailDTO.Info> update(@Validated @RequestBody IncotermDetailDTO.Update request) {

        return new ResponseEntity<>(incotermDetailService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        incotermDetailService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermDetailDTO.Delete request) {

        incotermDetailService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<IncotermDetailDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(incotermDetailService.search(nicicoCriteria), HttpStatus.OK);
    }
}
