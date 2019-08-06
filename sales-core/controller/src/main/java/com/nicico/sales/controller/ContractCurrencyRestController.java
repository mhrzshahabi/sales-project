package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContractCurrencyDTO;
import com.nicico.sales.iservice.IContractCurrencyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractCurrency")
public class ContractCurrencyRestController {

	private final IContractCurrencyService contractCurrencyService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_contractCurrency')")
	public ResponseEntity<ContractCurrencyDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractCurrencyService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_contractCurrency')")
	public ResponseEntity<List<ContractCurrencyDTO.Info>> list() {
		return new ResponseEntity<>(contractCurrencyService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_contractCurrency')")
	public ResponseEntity<ContractCurrencyDTO.Info> create(@Validated @RequestBody ContractCurrencyDTO.Create request) {
		return new ResponseEntity<>(contractCurrencyService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_contractCurrency')")
	public ResponseEntity<ContractCurrencyDTO.Info> update(@RequestBody ContractCurrencyDTO.Update request) {
		return new ResponseEntity<>(contractCurrencyService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_contractCurrency')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractCurrencyService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_contractCurrency')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractCurrencyDTO.Delete request) {
		contractCurrencyService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_contractCurrency')")
	public ResponseEntity<ContractCurrencyDTO.ContractCurrencySpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractCurrencyDTO.Info> response = contractCurrencyService.search(request);

		final ContractCurrencyDTO.SpecRs specResponse = new ContractCurrencyDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractCurrencyDTO.ContractCurrencySpecRs specRs = new ContractCurrencyDTO.ContractCurrencySpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_contractCurrency')")
	public ResponseEntity<SearchDTO.SearchRs<ContractCurrencyDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractCurrencyService.search(request), HttpStatus.OK);
	}
}
