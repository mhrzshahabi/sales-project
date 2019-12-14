package com.nicico.sales.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GroupsPersonDTO;
import com.nicico.sales.iservice.IGroupsPersonService;
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
@RequestMapping(value = "/api/groupsPerson")
public class GroupsPersonRestController {

    private final IGroupsPersonService groupsPersonService;
    private final ObjectMapper objectMapper;
    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
    //@PreAuthorize("hasAuthority('r_groupsPerson')")
    public ResponseEntity<GroupsPersonDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(groupsPersonService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //@PreAuthorize("hasAuthority('r_groupsPerson')")
    public ResponseEntity<List<GroupsPersonDTO.Info>> list() {
        return new ResponseEntity<>(groupsPersonService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    //@PreAuthorize("hasAuthority('c_groupsPerson')")
    public ResponseEntity<GroupsPersonDTO.Info> create(@Validated @RequestBody GroupsPersonDTO.Create request) {
        return new ResponseEntity<>(groupsPersonService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    //@PreAuthorize("hasAuthority('u_groupsPerson')")
    public ResponseEntity<GroupsPersonDTO.Info> update(@RequestBody GroupsPersonDTO.Update request) {
        return new ResponseEntity<>(groupsPersonService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    //@PreAuthorize("hasAuthority('d_groupsPerson')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        groupsPersonService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    //@PreAuthorize("hasAuthority('d_groupsPerson')")
    public ResponseEntity<Void> delete(@Validated @RequestBody GroupsPersonDTO.Delete request) {
        groupsPersonService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<GroupsPersonDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(groupsPersonService.search(nicicoCriteria), HttpStatus.OK);
    }
    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
    //@PreAuthorize("hasAuthority('r_groupsPerson')")
    public ResponseEntity<SearchDTO.SearchRs<GroupsPersonDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(groupsPersonService.search(request), HttpStatus.OK);
    }
}
