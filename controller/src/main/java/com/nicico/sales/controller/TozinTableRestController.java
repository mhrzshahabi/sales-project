package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinTableDTO;
import com.nicico.sales.iservice.ITozinTableService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozin-table")
public class TozinTableRestController {

    private final ITozinTableService tozinService;

    @Loggable
    @GetMapping(value = {"/list"})
    public ResponseEntity<List<TozinTableDTO.Info>> list() {
        return new ResponseEntity<>(tozinService.list(), HttpStatus.OK);

    }

     @Loggable
    @DeleteMapping(value = {"/list"})
    public ResponseEntity batchDelete(@RequestBody TozinTableDTO.Delete ids) {
        tozinService.deleteAll(ids);
        return new ResponseEntity<>( HttpStatus.OK);
    }



    @Loggable
    @GetMapping(value = {"/spec-list"})
    public ResponseEntity<TotalResponse<TozinTableDTO.Info>> search(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(tozinService.search(nicicoCriteria), HttpStatus.OK);

    }


}
