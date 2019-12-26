package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentAssayItemDTO;
import com.nicico.sales.iservice.IShipmentAssayItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipmentAssayItem")
public class ShipmentAssayItemRestController {

    private final IShipmentAssayItemService shipmentAssayItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
    public ResponseEntity<ShipmentAssayItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentAssayItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
    public ResponseEntity<List<ShipmentAssayItemDTO.Info>> list() {
        return new ResponseEntity<>(shipmentAssayItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    //	@PreAuthorize("hasAuthority('c_shipmentAssayItem')")
    public ResponseEntity<ShipmentAssayItemDTO.Info> create(@Validated @RequestBody ShipmentAssayItemDTO.Create request) {
        return new ResponseEntity<>(shipmentAssayItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    //	@PreAuthorize("hasAuthority('u_shipmentAssayItem')")
    public ResponseEntity<ShipmentAssayItemDTO.Info> update(@RequestBody ShipmentAssayItemDTO.Update request) {
        return new ResponseEntity<>(shipmentAssayItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('d_shipmentAssayItem')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentAssayItemService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list/{ids}")
    //	@PreAuthorize("hasAuthority('d_shipmentAssayItem')")
    public ResponseEntity<Void> delete(@PathVariable String ids) {
        List<Long> i = new ArrayList<>();

        String[] sIds = ids.split(",");
        for (int j = 1; j < sIds.length; j++)
            i.add(new Long(sIds[j]));

        ShipmentAssayItemDTO.Delete request = new ShipmentAssayItemDTO.Delete();
        request.setIds(i);

        shipmentAssayItemService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
    public ResponseEntity<TotalResponse<ShipmentAssayItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentAssayItemService.search(nicicoCriteria), HttpStatus.OK);
    }

    @RequestMapping(value = {"/addAssayPaste"}, method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> createAddAssayPaste(@RequestBody String data) {
        return new ResponseEntity<>(shipmentAssayItemService.createAddAssayPaste(data), HttpStatus.OK);
    }
}
