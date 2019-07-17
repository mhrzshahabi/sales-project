package com.nicico.sales.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
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
@RequestMapping(value = "/api/contractIncomeCost")
public class ContractIncomeCostRestController {

    private final IContractIncomeCostService contractIncomeCostService;
    private final ReportUtil reportUtil;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractIncomeCostService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<List<ContractIncomeCostDTO.Info>> list() {
        return new ResponseEntity<>(contractIncomeCostService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//    @PreAuthorize("hasAuthority('c_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> create(@Validated @RequestBody ContractIncomeCostDTO.Create request) {
        return new ResponseEntity<>(contractIncomeCostService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//    @PreAuthorize("hasAuthority('u_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> update(@RequestBody ContractIncomeCostDTO.Update request) {
        return new ResponseEntity<>(contractIncomeCostService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_contractIncomeCost')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractIncomeCostService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_contractIncomeCost')")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractIncomeCostDTO.Delete request) {
        contractIncomeCostService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.ContractIncomeCostSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<ContractIncomeCostDTO.Info> response = contractIncomeCostService.search(request);

        final ContractIncomeCostDTO.SpecRs specResponse = new ContractIncomeCostDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final ContractIncomeCostDTO.ContractIncomeCostSpecRs specRs = new ContractIncomeCostDTO.ContractIncomeCostSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<SearchDTO.SearchRs<ContractIncomeCostDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractIncomeCostService.search(request), HttpStatus.OK);
    }
//---------------------------------------------------------------
@Loggable
@GetMapping(value = {"/print/{type}"})
public void print(HttpServletResponse response, @PathVariable String type) throws SQLException, IOException, JRException {
    Map<String, Object> params = new HashMap<>();
    params.put(ConstantVARs.REPORT_TYPE, type);
    reportUtil.export("/reports/ContractIncomeCost.jasper", params, response);
}


}
