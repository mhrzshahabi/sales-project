package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.iservice.IShipmentService;
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
@RequestMapping(value = "/api/invoice")
public class InvoiceRestController {

    private final IInvoiceService invoiceService;
    private final IShipmentService shipmentService;
    private final IInvoiceMolybdenumService invoiceMolybdenumService;
    private final ReportUtil reportUtil;

    @Loggable
    @PutMapping
    @RequestMapping("/sendForm-2accounting/{id}")
    public ResponseEntity<InvoiceDTO.Info> sendForm2accounting(@PathVariable Long id, @RequestBody String data) {
        return new ResponseEntity<InvoiceDTO.Info>(invoiceService.sendForm2accounting(id, data), HttpStatus.OK);
    }


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
//	@PreAuthorize("hasAuthority('r_instruction')")
    public ResponseEntity<TotalResponse<InvoiceDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(invoiceService.search(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/print/{type}/{rowId}")
    public void report(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws SQLException, IOException, JRException {
        Map<String, Object> params = new HashMap<>();
        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        Long shipmentId = invoiceService.get(Long.valueOf(rowId)).getShipmentId();
        String description = shipmentService.get(shipmentId).getMaterial().getDescl();
        if (description.toLowerCase().contains("Mol")) {
            reportUtil.export("/reports/Mo_Ox.jasper", params, response);
        } else if (description.toLowerCase().contains("Cat")) {
            reportUtil.export("/reports/CAD.jasper", params, response);
        } else if (description.toLowerCase().contains("Conc")) {
            reportUtil.export("/reports/Conc.jasper", params, response);
        }
    }
}
