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
    @GetMapping(value = "/showTransport2Plants/{date}")
    public ResponseEntity<String> list(@PathVariable("date") String date) throws IOException {
        String[] plants = tozinService.findPlants();
        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        String out = "";

        for (int i = 0; i < plants.length; i++) {
            String[] plantId = plants[i].split(",");
            out += "<table width='100%' align='center'  border='1' cellspacing='1' cellpadding='1'> <tbody><tr><td><b>" + plantId[1] + "</b></td> </tr> ";
            out += "<tr> . </tr><tr> </tr><tr><th>مبدا</th><th>مقصد</th><th>محصول</th><th>حمل</th><th>تناژ</th><th>تعداد</th></tr>";
            List<Object[]> list = tozinService.findTransport2Plants(day, plantId[0]);
            for (Object[] aa : list) {
                out += "<tr>";
                for (Object s : aa) {
                    out += "<td>" + s.toString() + "</td>";
                }
            }
            out += "</tr></table>";
        }
        return new ResponseEntity<>(out, HttpStatus.OK);
    }

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
