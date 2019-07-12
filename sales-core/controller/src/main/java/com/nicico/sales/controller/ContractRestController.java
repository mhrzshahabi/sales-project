package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping(value = "/api/contract")
public class ContractRestController {

	private final IContractService contractService;
	private final ObjectMapper objectMapper;
	private final ReportUtil reportUtil;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('r_contract')")
	public ResponseEntity<ContractDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	@PreAuthorize("hasAuthority('r_contract')")
	public ResponseEntity<List<ContractDTO.Info>> list() {
		return new ResponseEntity<>(contractService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	@PreAuthorize("hasAuthority('c_contract')")
	public ResponseEntity<ContractDTO.Info> create(@Validated @RequestBody ContractDTO.Create request) {
		return new ResponseEntity<>(contractService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	@PreAuthorize("hasAuthority('u_contract')")
	public ResponseEntity<ContractDTO.Info> update(@RequestBody ContractDTO.Update request) {
		return new ResponseEntity<>(contractService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('d_contract')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	@PreAuthorize("hasAuthority('d_contract')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractDTO.Delete request) {
		contractService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	@PreAuthorize("hasAuthority('r_contract')")
	public ResponseEntity<ContractDTO.ContractSpecRs> list(@RequestParam("_startRow") Integer startRow,
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
				criteriaRq.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractDTO.Info> response = contractService.search(request);

		final ContractDTO.SpecRs specResponse = new ContractDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractDTO.ContractSpecRs specRs = new ContractDTO.ContractSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	@PreAuthorize("hasAuthority('r_contract')")
	public ResponseEntity<SearchDTO.SearchRs<ContractDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractService.search(request), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = {"/print/{type}"})
	public void print(HttpServletResponse response, @PathVariable String type) throws SQLException, IOException, JRException {
		Map<String, Object> params = new HashMap<>();
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/Contract.jasper", params, response);
	}
	@Loggable
	@GetMapping(value = {"/printIncome/{type}"})
	public void printIncome(HttpServletResponse response, @PathVariable String type) throws SQLException, IOException, JRException {
		Map<String, Object> params = new HashMap<>();
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/ContractIncomeCosts.jasper", params, response);
	}
}
