package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CountryDTO;
import com.nicico.sales.iservice.ICountryService;
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
@RequestMapping(value = "/api/country")
public class CountryRestController {

    private final ICountryService countryService;
    private final ObjectMapper objectMapper;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<CountryDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(countryService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<CountryDTO.Info>> list() {
        return new ResponseEntity<>(countryService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<CountryDTO.Info> create(@Validated @RequestBody CountryDTO.Create request) {
        return new ResponseEntity<>(countryService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<CountryDTO.Info> update(@RequestBody CountryDTO.Update request) {
        return new ResponseEntity<>(countryService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        countryService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody CountryDTO.Delete request) {
        countryService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<CountryDTO.CountrySpecRs> list(@RequestParam("_startRow") Integer startRow,
                                                         @RequestParam("_endRow") Integer endRow,
                                                         @RequestParam(value = "_constructor", required = false) String constructor,
                                                         @RequestParam(value = "operator", required = false) String operator,
                                                         @RequestParam(value = "_sortBy", required = false) String sortBy,
                                                         @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        SearchDTO.CriteriaRq criteriaRq;
        if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
            criteria = "[" + criteria + "]";
            criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (StringUtils.isNotEmpty(sortBy)) {
                request.setSortBy(sortBy);
            }

            request.setCriteria(criteriaRq);
        }

        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<CountryDTO.Info> response = countryService.search(request);

        final CountryDTO.SpecRs specResponse = new CountryDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final CountryDTO.CountrySpecRs specRs = new CountryDTO.CountrySpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<CountryDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(countryService.search(request), HttpStatus.OK);
    }
}
