package com.nicico.sales.controller.report;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.report.IReportService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/report-execute")
public class ReportExecuteRestController {

    private final IReportService reportService;

    @Loggable
    @GetMapping(value = "/report-with-permission")
    public ResponseEntity<TotalResponse<ReportDTO.InfoWithAccess>> listByAccess(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(reportService.searchWithAccess(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/report-data/{reportId}/spec-list")
    public ResponseEntity<TotalResponse<Map<String, Object>>> getReportData(HttpServletRequest request, @PathVariable Long reportId, @RequestParam MultiValueMap<String, String> criteria) throws IOException {

        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/api/report-execute"));
        return new ResponseEntity<>(reportService.getReportData(reportId, baseUrl, NICICOCriteria.of(criteria)), HttpStatus.OK);
    }
}
