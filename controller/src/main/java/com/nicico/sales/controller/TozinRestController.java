package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozin")
public class TozinRestController {

    private final ITozinService tozinService;

    @Loggable
    @GetMapping(value = {"/spec-list"})
    public ResponseEntity<TotalResponse<TozinDTO.Info>> searchTozin(@RequestParam MultiValueMap<String, String> criteria) {
        if (criteria.containsKey("criteria") && criteria.get("criteria").get(0).contains("mazloom")) {
            criteria.get("criteria").remove(0);
            final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
            return new ResponseEntity<>(tozinService.searchTozinOnTheWay(nicicoCriteria, "SourceTozin"), HttpStatus.OK);
        } else {
            final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
            return new ResponseEntity<>(tozinService.searchTozin(nicicoCriteria), HttpStatus.OK);
        }
    }

    @Loggable
    @GetMapping(value = {"/search-tozin"})
    public ResponseEntity<TotalResponse<TozinDTO.Info>> searchTozinComboBijack(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinService.searchTozinOnTheWay(nicicoCriteria, "DestTozin"), HttpStatus.OK);

    }
}
