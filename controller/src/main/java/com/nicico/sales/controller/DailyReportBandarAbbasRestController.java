package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.DailyReportBandarAbbasDTO;
import com.nicico.sales.iservice.IDailyReportBandarAbbasService;
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
@RequestMapping(value = "/api/dailyReportBandarAbbas")
public class DailyReportBandarAbbasRestController {

    private final ObjectMapper objectMapper;
    private final IDailyReportBandarAbbasService dailyReportBandarAbbasService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<DailyReportBandarAbbasDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(dailyReportBandarAbbasService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<DailyReportBandarAbbasDTO.Info>> list() {
        return new ResponseEntity<>(dailyReportBandarAbbasService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<DailyReportBandarAbbasDTO.Info> create(@Validated @RequestBody DailyReportBandarAbbasDTO.Create request) {
        return new ResponseEntity<>(dailyReportBandarAbbasService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<DailyReportBandarAbbasDTO.Info> update(@RequestBody DailyReportBandarAbbasDTO.Update request) {
        return new ResponseEntity<>(dailyReportBandarAbbasService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        dailyReportBandarAbbasService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody DailyReportBandarAbbasDTO.Delete request) {
        dailyReportBandarAbbasService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<DailyReportBandarAbbasDTO.DailyReportBandarAbbasSpecRs> list(@RequestParam("_startRow") Integer startRow,
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
        SearchDTO.SearchRs<DailyReportBandarAbbasDTO.Info> response = dailyReportBandarAbbasService.search(request);

        final DailyReportBandarAbbasDTO.SpecRs specResponse = new DailyReportBandarAbbasDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final DailyReportBandarAbbasDTO.DailyReportBandarAbbasSpecRs specRs = new DailyReportBandarAbbasDTO.DailyReportBandarAbbasSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<DailyReportBandarAbbasDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(dailyReportBandarAbbasService.search(request), HttpStatus.OK);
    }
}
