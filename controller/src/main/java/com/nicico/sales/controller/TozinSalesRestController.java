package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinSalesDTO;
import com.nicico.sales.iservice.ITozinSalesService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
@RequestMapping(value = "/api/tozinSales")
public class TozinSalesRestController {

    private final ObjectMapper objectMapper;
    private final ITozinSalesService tozinSalesService;
    private final ReportUtil reportUtil;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_tozinSales')")
    public ResponseEntity<TozinSalesDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(tozinSalesService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_tozinSales')")
    public ResponseEntity<List<TozinSalesDTO.Info>> list() {
        return new ResponseEntity<>(tozinSalesService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//	@PreAuthorize("hasAuthority('c_tozinSales')")
    public ResponseEntity<TozinSalesDTO.Info> create(@Validated @RequestBody TozinSalesDTO.Create request) {
        return new ResponseEntity<>(tozinSalesService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//	@PreAuthorize("hasAuthority('u_tozinSales')")
    public ResponseEntity<TozinSalesDTO.Info> update(@RequestBody TozinSalesDTO.Update request) {
        return new ResponseEntity<>(tozinSalesService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_tozinSales')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        tozinSalesService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_tozinSales')")
    public ResponseEntity<Void> delete(@Validated @RequestBody TozinSalesDTO.Delete request) {
        tozinSalesService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_tozinSales')")
    public ResponseEntity<TozinSalesDTO.TozinSalesSpecRs> list(@RequestParam("_startRow") Integer startRow,
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

        SearchDTO.SearchRs<TozinSalesDTO.Info> response = tozinSalesService.search(request);

        final TozinSalesDTO.SpecRs specResponse = new TozinSalesDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final TozinSalesDTO.TozinSalesSpecRs specRs = new TozinSalesDTO.TozinSalesSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_tozinSales')")
    public ResponseEntity<SearchDTO.SearchRs<TozinSalesDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(tozinSalesService.search(request), HttpStatus.OK);
    }

    //---------------------------------------------------------------
    @Loggable
    @GetMapping(value = {"/print/{name}/{type}/{date}"})
    public void print(HttpServletResponse response, @PathVariable String name, @PathVariable String type, @PathVariable("date") String date) throws SQLException, IOException, JRException {
        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        Map<String, Object> params = new HashMap<>();
        params.put("dateReport", day);
        params.put(ConstantVARs.REPORT_TYPE, type);
        if (name.equals("Forosh_Bargiri")) {
            reportUtil.export("/reports/tozin_forosh_bargiri.jasper", params, response);
        } else if (name.equals("Kharid_Konstantere")) {
            reportUtil.export("/reports/tozin_kharid_konstantere.jasper", params, response);
        }else if (name.equals("Kharid_Zaieat")) {
            reportUtil.export("/reports/tozin_kharid_zayeat.jasper", params, response);
        }
    }

}
