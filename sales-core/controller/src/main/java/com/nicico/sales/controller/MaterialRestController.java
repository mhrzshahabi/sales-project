package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.MaterialDTO;
import com.nicico.sales.iservice.IMaterialService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/material")
public class MaterialRestController {

    private final IMaterialService materialService;
    private final ObjectMapper objectMapper;
    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_material')")
    public ResponseEntity<MaterialDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(materialService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_material')")
    public ResponseEntity<List<MaterialDTO.Info>> list() {
        return new ResponseEntity<>(materialService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//    @PreAuthorize("hasAuthority('c_material')")
    public ResponseEntity<MaterialDTO.Info> create(@Validated @RequestBody MaterialDTO.Create request) {
        return new ResponseEntity<>(materialService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//    @PreAuthorize("hasAuthority('u_material')")
    public ResponseEntity<MaterialDTO.Info> update(@RequestBody MaterialDTO.Update request) {
        return new ResponseEntity<>(materialService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_material')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        materialService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_material')")
    public ResponseEntity<Void> delete(@Validated @RequestBody MaterialDTO.Delete request) {
        materialService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_material')")
    public ResponseEntity<MaterialDTO.MaterialSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "_constructor", required = false) String constructor,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "_sortBy", required = false) String sortBy,
            @RequestParam(value = "criteria", required = false) String criteria
    ) throws IOException {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        SearchDTO.CriteriaRq criteriaRq;
        if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
            criteria = "[" + criteria + "]";
            criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (StringUtils.isNotEmpty(sortBy)) {
                criteriaRq.set_sortBy(sortBy);
            }

            request.setCriteria(criteriaRq);
        }

        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<MaterialDTO.Info> response = materialService.search(request);

        final MaterialDTO.SpecRs specResponse = new MaterialDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final MaterialDTO.MaterialSpecRs specRs = new MaterialDTO.MaterialSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_material')")
    public ResponseEntity<SearchDTO.SearchRs<MaterialDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(materialService.search(request), HttpStatus.OK);
    }
}
