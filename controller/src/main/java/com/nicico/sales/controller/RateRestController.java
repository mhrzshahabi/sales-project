package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.RateDTO;
import com.nicico.sales.iservice.IRateService;
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
@RequestMapping(value = "/api/rate")
public class RateRestController {

    private final IRateService rateService;

    @Loggable
    @GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_rate')")
    public ResponseEntity<RateDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(rateService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_rate')")
    public ResponseEntity<List<RateDTO.Info>> list() {
        return new ResponseEntity<>(rateService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//	@PreAuthorize("hasAuthority('c_rate')")
    public ResponseEntity<RateDTO.Info> create(@Validated @RequestBody RateDTO.Create request) {
        return new ResponseEntity<>(rateService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//	@PreAuthorize("hasAuthority('u_rate')")
    public ResponseEntity<RateDTO.Info> update(@RequestBody RateDTO.Update request) {
        return new ResponseEntity<>(rateService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_rate')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        rateService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_rate')")
    public ResponseEntity<Void> delete(@Validated @RequestBody RateDTO.Delete request) {
        rateService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<RateDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(rateService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_rate')")
    public ResponseEntity<SearchDTO.SearchRs<RateDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(rateService.search(request), HttpStatus.OK);
    }
}
