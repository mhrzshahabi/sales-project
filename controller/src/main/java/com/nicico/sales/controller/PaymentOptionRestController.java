package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PaymentOptionDTO;
import com.nicico.sales.iservice.IPaymentOptionService;
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
@RequestMapping(value = "/api/paymentOption")
public class PaymentOptionRestController {

    private final IPaymentOptionService paymentOptionService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<PaymentOptionDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(paymentOptionService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<PaymentOptionDTO.Info>> list() {
        return new ResponseEntity<>(paymentOptionService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<PaymentOptionDTO.Info> create(@Validated @RequestBody PaymentOptionDTO.Create request) {
        return new ResponseEntity<>(paymentOptionService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<PaymentOptionDTO.Info> update(@RequestBody PaymentOptionDTO.Update request) {
        return new ResponseEntity<>(paymentOptionService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        paymentOptionService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody PaymentOptionDTO.Delete request) {
        paymentOptionService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<PaymentOptionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(paymentOptionService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<PaymentOptionDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(paymentOptionService.search(request), HttpStatus.OK);
    }
}
