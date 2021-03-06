package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialItemDTO;
import com.nicico.sales.iservice.IMaterialItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/materialItem")
public class MaterialItemRestController {

    private final IMaterialItemService materialItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<MaterialItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(materialItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<MaterialItemDTO.Info>> list() {
        return new ResponseEntity<>(materialItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<MaterialItemDTO.Info>> updateAll() {
        materialItemService.updateFromTozinView();
        return new ResponseEntity<>(materialItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<MaterialItemDTO.Info> create(@Validated @RequestBody MaterialItemDTO.Create request) {
        return new ResponseEntity<>(materialItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<MaterialItemDTO.Info> update(@RequestBody MaterialItemDTO.Update request) {
        return new ResponseEntity<>(materialItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        materialItemService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody MaterialItemDTO.Delete request) {
        materialItemService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<MaterialItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(materialItemService.search(nicicoCriteria), HttpStatus.OK);
    }
     @Loggable
    @GetMapping(value = "/spec-list-with-inventories")
    public ResponseEntity<TotalResponse<MaterialItemDTO.InfoWithInventories>> listWithInventories(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(materialItemService.searchWithInventories(nicicoCriteria), HttpStatus.OK);
    }

}
