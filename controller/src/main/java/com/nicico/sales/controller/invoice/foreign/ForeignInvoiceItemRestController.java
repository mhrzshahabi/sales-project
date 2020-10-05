package com.nicico.sales.controller.invoice.foreign;

import com.google.common.base.Enums;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.enumeration.AllConverters;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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
    @GetMapping(value = "/get-calculation2-data")
    public ResponseEntity<ForeignInvoiceItemDTO.Calc2Data> getCalculation2Data(@RequestParam Long contractId, @RequestParam PriceBaseReference reference, @RequestParam Integer year, @RequestParam Integer month, @RequestParam Long financeUnitId ,@RequestParam Long inspectionAssayDataId, @RequestParam Long inspectionWeightDataId) {

        return new ResponseEntity<>(foreignInvoiceItemService.getCalculation2Data(contractId, reference, year, month, financeUnitId, inspectionAssayDataId, inspectionWeightDataId), HttpStatus.OK);
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
