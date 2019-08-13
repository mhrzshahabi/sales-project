package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.iservice.IBankService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
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
@RequestMapping(value = "/api/bank")
public class BankRestController {

    private final IBankService bankService;
    private final ReportUtil reportUtil;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_bank')")
    public ResponseEntity<BankDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(bankService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_bank')")
    public ResponseEntity<List<BankDTO.Info>> list() {
        return new ResponseEntity<>(bankService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//    @PreAuthorize("hasAuthority('c_bank')")
    public ResponseEntity<BankDTO.Info> create(@Validated @RequestBody BankDTO.Create request) {
        return new ResponseEntity<>(bankService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//    @PreAuthorize("hasAuthority('u_bank')")
    public ResponseEntity<BankDTO.Info> update(@RequestBody BankDTO.Update request) {
        return new ResponseEntity<>(bankService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_bank')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        bankService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_bank')")
    public ResponseEntity<Void> delete(@Validated @RequestBody BankDTO.Delete request) {
        bankService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_bank')")
    public ResponseEntity<BankDTO.BankSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<BankDTO.Info> response = bankService.search(request);

        final BankDTO.SpecRs specResponse = new BankDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final BankDTO.BankSpecRs specRs = new BankDTO.BankSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_bank')")
    public ResponseEntity<SearchDTO.SearchRs<BankDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(bankService.search(request), HttpStatus.OK);
    }
//---------------------------------------------------------------
@Loggable
@GetMapping(value = {"/print/{type}"})
public void print(HttpServletResponse response, @PathVariable String type) throws SQLException, IOException, JRException {
    Map<String, Object> params = new HashMap<>();
    params.put(ConstantVARs.REPORT_TYPE, type);
    reportUtil.export("/reports/Bank.jasper", params, response);
}


}
