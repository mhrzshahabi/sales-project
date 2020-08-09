package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinLiteService;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.TozinLite;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozin")
public class TozinRestController {

    private final ITozinService tozinService;
    private final ITozinLiteService tozinLiteService;
//    private final ObjectMapper mapper;

    @Loggable
    @GetMapping(value = {"/spec-list"})
    public ResponseEntity<TotalResponse<TozinDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinService.searchTozin(nicicoCriteria), HttpStatus.OK);

    }

    @Loggable
    @GetMapping(value = {"/lite/spec-list"})
    public ResponseEntity<TotalResponse<TozinLite>> searchLite(@RequestParam MultiValueMap<String, String> criteria) {
//        Map<String,String> criteraHardFoookingCode = new HashMap<String,String>(){{
//            put("fieldName","tozinId");
//            put("operator","iNotStartsWith");
//            put("value","3-");
//        }};
//        try {
//            criteria.add("criteria",mapper.writeValueAsString(criteraHardFoookingCode));
//        } catch (JsonProcessingException e) {
//            log.error(e.getMessage());
//        }
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinLiteService.search(nicicoCriteria), HttpStatus.OK);
    }

}
