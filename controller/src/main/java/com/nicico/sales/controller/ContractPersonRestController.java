package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractPersonDTO;
import com.nicico.sales.iservice.IContractPersonService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractPerson")
public class ContractPersonRestController {

	private final IContractPersonService contractPersonService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_contractPerson')")
	public ResponseEntity<ContractPersonDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractPersonService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_contractPerson')")
	public ResponseEntity<List<ContractPersonDTO.Info>> list() {
		return new ResponseEntity<>(contractPersonService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	// @PreAuthorize("hasAuthority('c_contractPerson')")
	public ResponseEntity<ContractPersonDTO.Info> create(@Validated @RequestBody ContractPersonDTO.Create request) {
		return new ResponseEntity<>(contractPersonService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_contractPerson')")
	public ResponseEntity<ContractPersonDTO.Info> update(@RequestBody ContractPersonDTO.Update request) {
		return new ResponseEntity<>(contractPersonService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_contractPerson')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractPersonService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_contractPerson')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractPersonDTO.Delete request) {
		contractPersonService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	// @PreAuthorize("hasAuthority('r_contractPerson')")
	public ResponseEntity<ContractPersonDTO.ContractPersonSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractPersonDTO.Info> response = contractPersonService.search(request);

		final ContractPersonDTO.SpecRs specResponse = new ContractPersonDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractPersonDTO.ContractPersonSpecRs specRs = new ContractPersonDTO.ContractPersonSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_contractPerson')")
	public ResponseEntity<SearchDTO.SearchRs<ContractPersonDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractPersonService.search(request), HttpStatus.OK);
	}
}
