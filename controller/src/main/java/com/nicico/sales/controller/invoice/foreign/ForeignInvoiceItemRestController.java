package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/api/foreign-invoice-item")
public class ForeignInvoiceItemRestController {

    private final IForeignInvoiceItemService foreignInvoiceItemService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoiceItemDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceItemService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoiceItemDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoiceItemService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/get-calculation2-data")
    public ResponseEntity<ForeignInvoiceItemDTO.Calc2Data> getCalculation2Data(@RequestParam Long contractId, @RequestParam @DateTimeFormat(pattern = "MM/dd/yyyy") Date sendDate,
                                                                               @RequestParam Long financeUnitId, @RequestParam Long inspectionAssayDataId,
                                                                               @RequestParam Long inspectionWeightDataId, @RequestBody ContractDetailDataDTO.Info contractDetailDataInfo) {

        return new ResponseEntity<>(foreignInvoiceItemService.getCalculation2Data(contractId, sendDate, financeUnitId, inspectionAssayDataId, inspectionWeightDataId, contractDetailDataInfo), HttpStatus.OK);
    }


    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoiceItemDTO.Info> create(@Validated @RequestBody ForeignInvoiceItemDTO.Create request) {

        return new ResponseEntity<>(foreignInvoiceItemService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoiceItemDTO.Info> update(@Validated @RequestBody ForeignInvoiceItemDTO.Update request) {

        return new ResponseEntity<>(foreignInvoiceItemService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoiceItemService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoiceItemDTO.Delete request) {

        foreignInvoiceItemService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoiceItemDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoiceItemService.search(nicicoCriteria), HttpStatus.OK);
    }
}
