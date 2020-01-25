package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PersonDTO;
import com.nicico.sales.iservice.IPersonService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/person")
public class PersonRestController {

    private final IPersonService personService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<PersonDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(personService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PersonDTO.Info>> list() {
        return new ResponseEntity<>(personService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PersonDTO.Info> create(@Validated @RequestBody PersonDTO.Create request) {
        return new ResponseEntity<>(personService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<PersonDTO.Info> update(@RequestBody PersonDTO.Update request) {
        return new ResponseEntity<>(personService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        personService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody PersonDTO.Delete request) {
        personService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PersonDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(personService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<PersonDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(personService.search(request), HttpStatus.OK);
    }
}
