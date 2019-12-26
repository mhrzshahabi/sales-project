package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseCadItemDTO;
import com.nicico.sales.iservice.IWarehouseCadItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/warehouseCadItem")
public class WarehouseCadItemRestController {

    private final IWarehouseCadItemService warehouseCadItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<WarehouseCadItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(warehouseCadItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<WarehouseCadItemDTO.Info>> list() {
        return new ResponseEntity<>(warehouseCadItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<WarehouseCadItemDTO.Info> create(@Validated @RequestBody WarehouseCadItemDTO.Create request) {
        return new ResponseEntity<>(warehouseCadItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<WarehouseCadItemDTO.Info> update(@RequestBody WarehouseCadItemDTO.Update request) {
        return new ResponseEntity<>(warehouseCadItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        warehouseCadItemService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity delete(@Validated @RequestBody WarehouseCadItemDTO.Delete request) {
        warehouseCadItemService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<WarehouseCadItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
//        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseCadItemService.search(criteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list-issue-cad")
    public ResponseEntity<TotalResponse<WarehouseCadItemDTO.InfoCombo2>> list1(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(warehouseCadItemService.search1(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list-ids/{ids}")
    public ResponseEntity<List<WarehouseCadItemDTO.Info>> listIds(@PathVariable String ids) throws IOException {
        List<Long> i = new ArrayList<>();

        String[] sIds = ids.split(",");
        for (int j = 0; j < sIds.length; j++)
            i.add(new Long(sIds[j]));

        WarehouseCadItemDTO.Delete request = new WarehouseCadItemDTO.Delete();
        request.setIds(i);

        final NICICOCriteria nicicoCriteria = new NICICOCriteria().set_startRow(0).set_endRow(1000).setOperator("and");
        SearchDTO.SearchRs<WarehouseCadItemDTO.Info> aa = warehouseCadItemService.search(request);
        return new ResponseEntity<>(aa.getList(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/search")
    public ResponseEntity<SearchDTO.SearchRs<WarehouseCadItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(warehouseCadItemService.search(request), HttpStatus.OK);
    }
}
