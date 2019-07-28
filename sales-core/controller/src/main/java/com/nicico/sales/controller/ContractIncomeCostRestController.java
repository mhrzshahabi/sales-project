package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.*;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import com.nicico.sales.model.entities.base.ContractIncomeCost;
import com.nicico.sales.util.ReportBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JRDesignField;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;
import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.rmi.RemoteException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractIncomeCost")
public class ContractIncomeCostRestController {

    private final IContractIncomeCostService contractIncomeCostService;
    private final ObjectMapper objectMapper;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractIncomeCostService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<List<ContractIncomeCostDTO.Info>> list() {
        return new ResponseEntity<>(contractIncomeCostService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.ContractIncomeCostSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<ContractIncomeCostDTO.Info> response = contractIncomeCostService.search(request);

        final ContractIncomeCostDTO.SpecRs specResponse = new ContractIncomeCostDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final ContractIncomeCostDTO.ContractIncomeCostSpecRs specRs = new ContractIncomeCostDTO.ContractIncomeCostSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<SearchDTO.SearchRs<ContractIncomeCostDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractIncomeCostService.search(request), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/print")
    public ResponseEntity<?> print(
            @RequestParam("type") String type,
            @RequestParam("operator") String operator,
            @RequestParam("criteria") String criteria,
            @RequestParam("preferences") String preferences
    ) {
        try {
            SearchDTO.SearchRq request = new SearchDTO.SearchRq();

            preferences = java.net.URLDecoder.decode(preferences, StandardCharsets.UTF_8.name());
            preferences = preferences.replaceAll(":", "\":");
            preferences = preferences.replaceAll("\\{", "\\{\"");
            preferences = preferences.replaceAll(",", ",\"");
            preferences = preferences.replaceAll("\"\\{", "\\{");

            JsonParser jsonParser = JsonParserFactory.getJsonParser();
            Map<String, Object> preferencesMap = jsonParser.parseMap(preferences);
            ArrayList<String> columns = new ArrayList<>();
            for (Map<String, Object> field : (ArrayList<Map<String, Object>>) preferencesMap.get("field")) {
                if (!field.containsKey("visible")) {
                    columns.add(field.get("name").toString());
                }
            }

            criteria = java.net.URLDecoder.decode(criteria, StandardCharsets.UTF_8.name());
            if (criteria.equals(""))
                criteria = "[" + criteria + "]";
            SearchDTO.CriteriaRq criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (preferencesMap.containsKey("sort")) {
                List<String> sortByList = new ArrayList<>();
                for (Map<String, Object> sort : (ArrayList<Map<String, Object>>) ((Map) preferencesMap.get("sort")).get("sortSpecifiers")) {
                    if (sort.get("direction").equals("descending")) {
                        sortByList.add("-" + sort.get("property"));
                    } else {
                        sortByList.add(sort.get("property").toString());
                    }
                }
                request.set_sortBy(sortByList);
            }

            request.setCriteria(criteriaRq);
            request.setStartIndex(0).setCount(50);

            List<ContractIncomeCostDTO.Info> searchList = contractIncomeCostService.search(request).getList();

            contractIncomeCostService.pdfFx(searchList, columns);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
