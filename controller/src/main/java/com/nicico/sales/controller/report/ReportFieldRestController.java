package com.nicico.sales.controller.report;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.report.ReportFieldDTO;
import com.nicico.sales.iservice.report.IReportFieldService;
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
@RequestMapping(value = "/api/reportField")
public class ReportFieldRestController {

    private final IReportFieldService reportFieldService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ReportFieldDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(reportFieldService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ReportFieldDTO.Info>> list() {
        return new ResponseEntity<>(reportFieldService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ReportFieldDTO.Info> create(@Validated @RequestBody ReportFieldDTO.Create request) {
        return new ResponseEntity<>(reportFieldService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ReportFieldDTO.Info> update(@RequestBody ReportFieldDTO.Update request) {
        return new ResponseEntity<>(reportFieldService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        reportFieldService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ReportFieldDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(reportFieldService.search(nicicoCriteria), HttpStatus.OK);
    }
}
