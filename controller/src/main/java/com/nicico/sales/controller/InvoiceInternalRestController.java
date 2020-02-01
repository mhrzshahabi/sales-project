package com.nicico.sales.controller;


import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceInternalDTO;
import com.nicico.sales.iservice.IInvoiceInternalService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
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
    private final ReportUtil reportUtil;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<InvoiceInternalDTO.Info> get(@PathVariable String id) {
        return new ResponseEntity<>(invoiceInternalService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<InvoiceInternalDTO.Info>> list() {
        return new ResponseEntity<>(invoiceInternalService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list-accounting/{ids}")
    public ResponseEntity<List<InvoiceInternalDTO.Info>> listAccounting(@PathVariable List<String> ids) {
        List<InvoiceInternalDTO.Info> lastIds = invoiceInternalService.getIds(ids);
        return new ResponseEntity<>(lastIds, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list-accounting")
    public ResponseEntity<TotalResponse<InvoiceInternalDTO.Info>> listAccountingLong(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        TotalResponse<InvoiceInternalDTO.Info> search = invoiceInternalService.search(nicicoCriteria);
        return new ResponseEntity<>(search, HttpStatus.OK);
    }


    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<InvoiceInternalDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceInternalService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @PutMapping
    @RequestMapping("/sendForm-2accounting/{id}")
    public ResponseEntity<InvoiceInternalDTO.Info> sendForm2accounting(@PathVariable String id, @RequestBody String data) {
        return new ResponseEntity<>(invoiceInternalService.sendInternalForm2accounting(id, data), HttpStatus.OK);
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
