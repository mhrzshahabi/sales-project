package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipment")
public class ShipmentRestController {

    private final IShipmentService shipmentService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ShipmentDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(shipmentService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ShipmentDTO.Info>> list() {
        return new ResponseEntity<>(shipmentService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ShipmentDTO.Info> create(@Validated @RequestBody ShipmentDTO.Create request) {
        return new ResponseEntity<>(shipmentService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ShipmentDTO.Info> update(@RequestBody ShipmentDTO.Update request) {
        Long id = request.getId();
        return new ResponseEntity<>(shipmentService.update(id, request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        shipmentService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentDTO.Delete request) {
        shipmentService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @Report(nameKey = "entity.shipment", returnType = ShipmentDTO.Info.class)
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ShipmentDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(shipmentService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/pick-list")
    public ResponseEntity<String> pickList(
            @RequestParam(value = "_startRow", required = false) Integer startRow,
            @RequestParam(value = "_endRow", required = false) Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        String body = "";
        startRow = (startRow == null ? 0 : startRow);
        endRow = (endRow == null ? 50 : endRow);
        if (startRow != null) {
            List<Object[]> list = shipmentService.pickListShipment();
            String[] fl = "cisId,contractNo,fullname,quantity,sendDate,contactID,materialID,materialDescp,contractID,loadPortID".split(",");
            int totalRows = 0;
            for (Object[] rs : list) {
                String line = "";
                for (int i = 0; i < fl.length; i++)
                    line += ", \"" + fl[i] + "\" : \"" + (rs[i] == null ? "" : rs[i].toString()) + "\"";
                body += ", { " + line.substring(1) + " } ";
                totalRows++;
            }
            body = "{ \"response\": {\"data\": [ " + (body.isEmpty() ? " " : body.substring(1)) + " ], \"startRow\": " + startRow + " , \"endRow\": " + endRow + " , \"totalRows\": " + totalRows + "  } } ";
        } else
            body = "{ \"response\": {\"data\": [ ], \"startRow\": 0, \"endRow\": 50 , \"totalRows\": 0  } } ";

        ResponseEntity responseEntity = new ResponseEntity(body, HttpStatus.OK);
        return responseEntity;
    }
}
