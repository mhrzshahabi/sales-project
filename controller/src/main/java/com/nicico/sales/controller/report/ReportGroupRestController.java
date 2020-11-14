package com.nicico.sales.controller.report;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.report.ReportGroupDTO;
import com.nicico.sales.iservice.report.IReportGroupService;
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
@RequestMapping(value = "/api/report-group")
public class ReportGroupRestController {

    private final IReportGroupService reportGroupService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ReportGroupDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(reportGroupService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ReportGroupDTO.Info>> list() {
        return new ResponseEntity<>(reportGroupService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ReportGroupDTO.Info> create(@Validated @RequestBody ReportGroupDTO.Create request) {
        return new ResponseEntity<>(reportGroupService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ReportGroupDTO.Info> update(@RequestBody ReportGroupDTO.Update request) {
        return new ResponseEntity<>(reportGroupService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        reportGroupService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ReportGroupDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(reportGroupService.search(nicicoCriteria), HttpStatus.OK);
    }
}
