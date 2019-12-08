package com.nicico.sales.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceInternalDTO;
import com.nicico.sales.iservice.IInvoiceInternalService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
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
@RequestMapping(value = "/api/invoiceInternal")
public class InvoiceInternalRestController {

    private final IInvoiceInternalService invoiceInternalService;
    private final ObjectMapper objectMapper;
    private final ReportUtil reportUtil;
    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
    //@PreAuthorize("hasAuthority('r_job')")
    public ResponseEntity<InvoiceInternalDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(invoiceInternalService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    //@PreAuthorize("hasAuthority('r_job')")
    public ResponseEntity<List<InvoiceInternalDTO.Info>> list() {
        return new ResponseEntity<>(invoiceInternalService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//	@PreAuthorize("hasAuthority('c_job')")
    public ResponseEntity<InvoiceInternalDTO.Info> create(@Validated @RequestBody InvoiceInternalDTO.Create request) {
        return new ResponseEntity<>(invoiceInternalService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('u_job')")
    public ResponseEntity<InvoiceInternalDTO.Info> update(@PathVariable Long id, @Validated @RequestBody InvoiceInternalDTO.Update request) {
        return new ResponseEntity<>(invoiceInternalService.update(id, request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_job')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        invoiceInternalService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_job')")
    public ResponseEntity<Void> delete(@Validated @RequestBody InvoiceInternalDTO.Delete request) {
        invoiceInternalService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_job')")
    public ResponseEntity<TotalResponse<InvoiceInternalDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceInternalService.search(nicicoCriteria), HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_job')")

    public ResponseEntity<SearchDTO.SearchRs<InvoiceInternalDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(invoiceInternalService.search(request), HttpStatus.OK);
    }

    @Loggable
    @PutMapping
    @RequestMapping("/sendForm-2accounting/{id}")
    public ResponseEntity<InvoiceInternalDTO.Info> sendForm2accounting(@PathVariable Long id, @RequestBody String data) {
        return new ResponseEntity<InvoiceInternalDTO.Info>(invoiceInternalService.sendInternalForm2accounting(id, data), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/print/{type}/{rowId}")
    public void report(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put(ConstantVARs.REPORT_TYPE, type);
        params.put("ID", rowId);
        reportUtil.export("/reports/invoice_dakheli.jasper", params, response);
    }
}
