package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.DepotDTO;
import com.nicico.sales.iservice.warehous.IDepotService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/depot")
public class DepotRestController {

    private final IDepotService service;

    @Loggable
    @GetMapping(value = {"/spec-list"})
    public ResponseEntity<TotalResponse<DepotDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(service.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<DepotDTO.Info>> list() {
        return new ResponseEntity<>(service.list(), HttpStatus.OK);
    }

}
