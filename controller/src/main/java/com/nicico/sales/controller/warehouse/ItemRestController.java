package com.nicico.sales.controller.warehouse;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.iservice.warehous.IItemService;
import com.nicico.sales.model.entities.warehouse.Item;
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
@RequestMapping(value = "/api/item")
public class ItemRestController {

    private final IItemService itemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<Item> get(@PathVariable Long id) {
        return new ResponseEntity(itemService.get(id), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<Item>> list() {
        return new ResponseEntity(itemService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/update-all")
    public ResponseEntity<List<Item>> updateFromTozinView() {
        itemService.updateFromTozinView();
        return new ResponseEntity(itemService.list(), HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<Item>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity(itemService.search(nicicoCriteria), HttpStatus.OK);
    }

}
