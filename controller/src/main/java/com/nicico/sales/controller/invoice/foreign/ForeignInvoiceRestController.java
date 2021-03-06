package com.nicico.sales.controller.invoice.foreign;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
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
@RequestMapping(value = "/api/foreign-invoice")
public class ForeignInvoiceRestController {

    private final IForeignInvoiceService foreignInvoiceService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ForeignInvoiceDTO.Info>> list() {

        return new ResponseEntity<>(foreignInvoiceService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ForeignInvoiceDTO.Info> create(@Validated @RequestBody ForeignInvoiceDTO.Create request) {

        return new ResponseEntity<>(foreignInvoiceService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PostMapping(value = "/activate/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> activate(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.activate(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/deactivate/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> deactivate(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.deactivate(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/finalize/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> finalize(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.finalize(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/disapprove/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> disapprove(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.disapprove(id), HttpStatus.OK);
    }

    @Loggable
    @PostMapping(value = "/back-to-unSent/{id}")
    public ResponseEntity<ForeignInvoiceDTO.Info> toUnsent(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.toUnsent(id), HttpStatus.OK);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ForeignInvoiceDTO.Info> update(@Validated @RequestBody ForeignInvoiceDTO.Update request) {

        return new ResponseEntity<>(foreignInvoiceService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        foreignInvoiceService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ForeignInvoiceDTO.Delete request) {

        foreignInvoiceService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/acc-info/{id}")
    public ResponseEntity<ForeignInvoiceDTO.AccInfo> getAccInfo(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.getAccInfo(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/heavy-info/{id}")
    public ResponseEntity<ForeignInvoiceDTO.HeavyInfo> getHeavyInfo(@PathVariable Long id) {

        return new ResponseEntity<>(foreignInvoiceService.getHeavyInfo(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-by-shipment")
    public ResponseEntity<List<ForeignInvoiceDTO.Info>> getByShipment(@RequestParam Long invoiceTypeId, @RequestParam Long shipmentId, @RequestParam Long currencyId) {

        return new ResponseEntity<>(foreignInvoiceService.getByShipment(invoiceTypeId, shipmentId, currencyId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-contract-detail-data")
    public ResponseEntity<ContractDetailDataDTO.Info> getContractDetailData(@RequestParam Long contractId) {

        return new ResponseEntity<>(foreignInvoiceService.getContractDetailData(contractId), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/update-deleted-document")
    public ResponseEntity<Void> updateDeletedDocument(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        TotalResponse<ForeignInvoiceDTO.Info> search = foreignInvoiceService.search(nicicoCriteria);
        if (search.getResponse().getTotalRows() > 0)
            foreignInvoiceService.updateDeletedDocument(search.getResponse().getData());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ForeignInvoiceDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(foreignInvoiceService.search(nicicoCriteria), HttpStatus.OK);
    }
}
