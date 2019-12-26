package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;
import com.nicico.sales.iservice.IShipmentMoistureItemService;
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
@RequestMapping(value = "/api/shipmentMoistureItem")
public class ShipmentMoistureItemRestController {

    private final IShipmentMoistureItemService shipmentMoistureItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
    public ResponseEntity<ShipmentMoistureItemDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentMoistureItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
    public ResponseEntity<List<ShipmentMoistureItemDTO.Info>> list() {
        return new ResponseEntity<>(shipmentMoistureItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    //	@PreAuthorize("hasAuthority('c_shipmentMoistureItem')")
    public ResponseEntity<ShipmentMoistureItemDTO.Info> create(@Validated @RequestBody ShipmentMoistureItemDTO.Create request) {
        return new ResponseEntity<>(shipmentMoistureItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    //	@PreAuthorize("hasAuthority('u_shipmentMoistureItem')")
    public ResponseEntity<ShipmentMoistureItemDTO.Info> update(@RequestBody ShipmentMoistureItemDTO.Update request) {
        return new ResponseEntity<>(shipmentMoistureItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    //	@PreAuthorize("hasAuthority('d_shipmentMoistureItem')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentMoistureItemService.delete(id);
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

        ShipmentMoistureItemDTO.Delete request = new ShipmentMoistureItemDTO.Delete();
        request.setIds(i);

        shipmentMoistureItemService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
    public ResponseEntity<TotalResponse<ShipmentMoistureItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentMoistureItemService.search(nicicoCriteria), HttpStatus.OK);
    }

    @RequestMapping(value = {"/addMoisturePaste"}, method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> createAddMoisturePaste(@RequestBody String data) {
        return new ResponseEntity<>(shipmentMoistureItemService.createAddMoisturePaste(data), HttpStatus.OK);
    }
}
