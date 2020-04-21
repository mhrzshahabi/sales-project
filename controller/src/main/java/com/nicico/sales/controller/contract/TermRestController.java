package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.TermDTO;
import com.nicico.sales.iservice.contract.ITermService;
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
@RequestMapping(value = "/api/term")
public class TermRestController {

    private final ITermService termService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<TermDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(termService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<TermDTO.Info>> list() {

        return new ResponseEntity<>(termService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<TermDTO.Info> create(@Validated @RequestBody TermDTO.Create request) {

        return new ResponseEntity<>(termService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<TermDTO.Info> update(@RequestBody TermDTO.Update request) {

        return new ResponseEntity<>(termService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        termService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody TermDTO.Delete request) {

        termService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<TermDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(termService.search(nicicoCriteria), HttpStatus.OK);
    }
}
