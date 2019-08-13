package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
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
            @RequestParam("preferences") String preferences,
            HttpServletResponse httpServletResponse
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
            ArrayList<String> fields = new ArrayList<>();
            for (Map<String, Object> field : (ArrayList<Map<String, Object>>) preferencesMap.get("field")) {
                if (!field.containsKey("visible")) {
                    if ((type.equals("pdf") || type.equals("excel")) && (columns.size() >= 8 || field.size() >= 8)) { // view exceeded problem!
                        continue;
                    }
                    columns.add(field.get("title").toString());
                    fields.add(field.get("name").toString());
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
                request.setSortBy(sortByList);
            }

            request.setCriteria(criteriaRq);
            request.setStartIndex(0).setCount(50);

            List<ContractIncomeCostDTO.Info> searchList = contractIncomeCostService.search(request).getList();

            contractIncomeCostService.pdfFx(searchList, columns, fields, type, httpServletResponse);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
