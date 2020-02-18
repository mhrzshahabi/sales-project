package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.GroupsDTO;
import com.nicico.sales.iservice.IGroupsService;
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
@RequestMapping(value = "/api/groups")
public class GroupsRestController {

    private final IGroupsService groupsService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<GroupsDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(groupsService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<GroupsDTO.Info>> list() {
        return new ResponseEntity<>(groupsService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<GroupsDTO.Info> create(@Validated @RequestBody GroupsDTO.Create request) {
        return new ResponseEntity<>(groupsService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<GroupsDTO.Info> update(@RequestBody GroupsDTO.Update request) {
        return new ResponseEntity<>(groupsService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        groupsService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody GroupsDTO.Delete request) {
        groupsService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<GroupsDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(groupsService.search(nicicoCriteria), HttpStatus.OK);
    }
}
