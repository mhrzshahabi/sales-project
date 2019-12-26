package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContactAccountDTO;
import com.nicico.sales.iservice.IContactAccountService;
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
@RequestMapping(value = "/api/contactAccount")
public class ContactAccountRestController {

    private final IContactAccountService contactAccountService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContactAccountDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contactAccountService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContactAccountDTO.Info>> list() {
        return new ResponseEntity<>(contactAccountService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContactAccountDTO.Info> create(@Validated @RequestBody ContactAccountDTO.Create request) {
        return new ResponseEntity<>(contactAccountService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContactAccountDTO.Info> update(@RequestBody ContactAccountDTO.Update request) {
        return new ResponseEntity<>(contactAccountService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contactAccountService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContactAccountDTO.Delete request) {
        contactAccountService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContactAccountDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contactAccountService.search(nicicoCriteria), HttpStatus.OK);
    }
}
