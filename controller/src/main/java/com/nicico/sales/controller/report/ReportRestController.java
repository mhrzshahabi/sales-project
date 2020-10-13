package com.nicico.sales.controller.report;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Enums;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.report.IReportFieldService;
import com.nicico.sales.iservice.report.IReportService;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.service.FileService;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/report")
public class ReportRestController {

    private final ObjectMapper objectMapper;
    private final IReportService reportService;
    private final IReportFieldService reportFieldService;
    private final SpecListUtil specListUtil;
    private final FileService fileService;
    private final ModelMapper modelMapper;

    @Loggable
    @GetMapping("/sources")
    public ResponseEntity<Map<String, Object>> getSourceData(@RequestParam String reportSource) {

        ReportSource reportSourceEnum = Enums.getIfPresent(ReportSource.class, reportSource).or(ReportSource.View);
        List<ReportDTO.SourceData> sourceData = reportService.getSourceData(reportSourceEnum);
        return new ResponseEntity<>(specListUtil.getCoveredByResponse(sourceData), HttpStatus.OK);
    }

    @Loggable
    @GetMapping("/sources-fields")
    public ResponseEntity<Map<String, Object>> getSourceFields(@RequestParam String reportSource, @RequestParam String source) {

        ReportSource reportSourceEnum = Enums.getIfPresent(ReportSource.class, reportSource).or(ReportSource.View);
        List<ReportDTO.FieldData> sourceFields = reportService.getSourceFields(reportSourceEnum, source);
        return new ResponseEntity<>(specListUtil.getCoveredByResponse(sourceFields), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ReportDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(reportService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ReportDTO.Info>> list() {
        return new ResponseEntity<>(reportService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    @Transactional
    public ResponseEntity<ReportDTO.Info> create(
            @RequestParam(value = "files", required = false) List<MultipartFile> files,
            @RequestParam("fileMetaData") String fileMetaData,
            @RequestParam("data") String data) throws IOException, IllegalAccessException, NoSuchFieldException, InvocationTargetException {
        return new ResponseEntity<>(reportService.create(files, fileMetaData, data), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ReportDTO.Info> update(@RequestBody ReportDTO.Update request) {
        return new ResponseEntity<>(reportService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        reportService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ReportDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(reportService.search(nicicoCriteria), HttpStatus.OK);
    }
}
