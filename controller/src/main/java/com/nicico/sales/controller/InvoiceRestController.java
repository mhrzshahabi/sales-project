package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.iservice.IShipmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/invoice")
public class InvoiceRestController {

    private final IInvoiceService invoiceService;
    private final IShipmentService shipmentService;
    private final IInvoiceMolybdenumService invoiceMolybdenumService;
    private final ObjectMapper objectMapper;
    private final ReportUtil reportUtil;

    @Loggable
    @PutMapping
    @RequestMapping("/sendForm-2accounting/{id}")
    public ResponseEntity<InvoiceDTO.Info> sendForm2accounting(@PathVariable Long id, @RequestBody String data) {
        return new ResponseEntity<InvoiceDTO.Info>(invoiceService.sendForm2accounting(id, data), HttpStatus.OK);
    }
    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
    // @PreAuthorize("hasAuthority('r_invoice')")
    public ResponseEntity<InvoiceDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(invoiceService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    // @PreAuthorize("hasAuthority('r_invoice')")
    public ResponseEntity<List<InvoiceDTO.Info>> list() {
        return new ResponseEntity<>(invoiceService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    // @PreAuthorize("hasAuthority('c_invoice')")
    public ResponseEntity<InvoiceDTO.Info> create(@Validated @RequestBody InvoiceDTO.Create request) {
        return new ResponseEntity<>(invoiceService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    // @PreAuthorize("hasAuthority('u_invoice')")
    public ResponseEntity<InvoiceDTO.Info> update(@RequestBody InvoiceDTO.Update request) {
        return new ResponseEntity<>(invoiceService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @PutMapping(value = "/molybdenum")
    // @PreAuthorize("hasAuthority('u_invoice')")
    public ResponseEntity<Void> molybdenum(@RequestBody String data) throws IOException {
        invoiceMolybdenumService.molybdenum(data);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    // @PreAuthorize("hasAuthority('d_invoice')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        invoiceService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    // @PreAuthorize("hasAuthority('d_invoice')")
    public ResponseEntity<Void> delete(@Validated @RequestBody InvoiceDTO.Delete request) {
        invoiceService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    // @PreAuthorize("hasAuthority('r_invoice')")
    public ResponseEntity<InvoiceDTO.InvoiceSpecRs> list(@RequestParam("_startRow") Integer startRow,
                                                         @RequestParam("_endRow") Integer endRow,
                                                         @RequestParam(value = "_constructor", required = false) String constructor,
                                                         @RequestParam(value = "operator", required = false) String operator,
                                                         @RequestParam(value = "_sortBy", required = false) String sortBy,
                                                         @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        SearchDTO.CriteriaRq criteriaRq;
        if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
            criteria = "[" + criteria + "]";
            criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (StringUtils.isNotEmpty(sortBy)) {
                request.setSortBy(sortBy);
            }

            request.setCriteria(criteriaRq);
        }

        request.setStartIndex(startRow)
                .setCount(endRow - startRow);
        SearchDTO.SearchRs<InvoiceDTO.Info> response = invoiceService.search(request);

        final InvoiceDTO.SpecRs specResponse = new InvoiceDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final InvoiceDTO.InvoiceSpecRs specRs = new InvoiceDTO.InvoiceSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
    // @PreAuthorize("hasAuthority('r_invoice')")
    public ResponseEntity<SearchDTO.SearchRs<InvoiceDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(invoiceService.search(request), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/print/{type}/{rowId}")
    public void report(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        Long shipmentId = invoiceService.get(Long.valueOf(rowId)).getShipmentId();
        String description = shipmentService.get(shipmentId).getMaterial().getDescl();
        if (description.contains("Molybdenum")) {
            reportUtil.export("/reports/Mo_Ox.jasper", params, response);
        } else if (description.contains("Cathode")) {
            reportUtil.export("/reports/CAD.jasper", params, response);
        } else if (description.contains("Concentrate")) {
            reportUtil.export("/reports/Conc.jasper", params, response);
        }
    }
}
