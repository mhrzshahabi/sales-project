package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialFeatureDTO;
import com.nicico.sales.iservice.IMaterialFeatureService;
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
@RequestMapping(value = "/api/materialFeature")
public class MaterialFeatureRestController {

    private final IMaterialFeatureService materialFeatureService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<MaterialFeatureDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(materialFeatureService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<MaterialFeatureDTO.Info>> list() {
        return new ResponseEntity<>(materialFeatureService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<MaterialFeatureDTO.Info> create(@Validated @RequestBody MaterialFeatureDTO.Create request) {
        return new ResponseEntity<>(materialFeatureService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<MaterialFeatureDTO.Info> update(@RequestBody MaterialFeatureDTO.Update request) {
        return new ResponseEntity<>(materialFeatureService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        materialFeatureService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody MaterialFeatureDTO.Delete request) {
        materialFeatureService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<MaterialFeatureDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(materialFeatureService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<MaterialFeatureDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(materialFeatureService.search(request), HttpStatus.OK);
    }
}
