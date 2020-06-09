package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.GoodsDTO;
import com.nicico.sales.iservice.IGoodsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/goods")
public class GoodsRestController {

    private final IGoodsService goodsService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<GoodsDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity(goodsService.get(id), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<GoodsDTO.Info>> list() {
        return new ResponseEntity(goodsService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<GoodsDTO.Info>> updateFromTozinView() {
        goodsService.updateFromTozinView();
        return new ResponseEntity(goodsService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<GoodsDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity(goodsService.search(nicicoCriteria), HttpStatus.OK);
    }

}
