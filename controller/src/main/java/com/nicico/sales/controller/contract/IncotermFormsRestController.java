//package com.nicico.sales.controller.contract;
//
//import com.nicico.copper.common.Loggable;
//import com.nicico.copper.common.domain.criteria.NICICOCriteria;
//import com.nicico.copper.common.dto.grid.TotalResponse;
//import com.nicico.sales.dto.contract.IncotermFormsDTO;
//import com.nicico.sales.iservice.contract.IIncotermFormsService;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.util.MultiValueMap;
//import org.springframework.validation.annotation.Validated;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@Slf4j
//@RequiredArgsConstructor
//@RestController
//@RequestMapping(value = "/api/incoterm-forms")
//public class IncotermFormsRestController {
//
//    private final IIncotermFormsService incotermFormsService;
//
//    @Loggable
//    @GetMapping(value = "/{id}")
//    public ResponseEntity<IncotermFormsDTO.Info> get(@PathVariable Long id) {
//
//        return new ResponseEntity<>(incotermFormsService.get(id), HttpStatus.OK);
//    }
//
//    @Loggable
//    @GetMapping(value = "/list")
//    public ResponseEntity<List<IncotermFormsDTO.Info>> list() {
//
//        return new ResponseEntity<>(incotermFormsService.list(), HttpStatus.OK);
//    }
//
//    @Loggable
//    @PostMapping
//    public ResponseEntity<IncotermFormsDTO.Info> create(@Validated @RequestBody IncotermFormsDTO.Create request) {
//
//        return new ResponseEntity<>(incotermFormsService.create(request), HttpStatus.CREATED);
//    }
//
//    @Loggable
//    @PutMapping
//    public ResponseEntity<IncotermFormsDTO.Info> update(@Validated @RequestBody IncotermFormsDTO.Update request) {
//
//        return new ResponseEntity<>(incotermFormsService.update(request.getId(), request), HttpStatus.OK);
//    }
//
//    @Loggable
//    @DeleteMapping(value = "/{id}")
//    public ResponseEntity<Void> delete(@PathVariable Long id) {
//
//        incotermFormsService.delete(id);
//        return new ResponseEntity<>(HttpStatus.OK);
//    }
//
//    @Loggable
//    @DeleteMapping(value = "/list")
//    public ResponseEntity<Void> delete(@Validated @RequestBody IncotermFormsDTO.Delete request) {
//
//        incotermFormsService.deleteAll(request);
//        return new ResponseEntity<>(HttpStatus.OK);
//    }
//
//    @Loggable
//    @GetMapping(value = "/spec-list")
//    public ResponseEntity<TotalResponse<IncotermFormsDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
//
//        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
//        return new ResponseEntity<>(incotermFormsService.search(nicicoCriteria), HttpStatus.OK);
//    }
//}
