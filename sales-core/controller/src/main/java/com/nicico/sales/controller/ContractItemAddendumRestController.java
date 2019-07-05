package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContractItemAddendumDTO;
import com.nicico.sales.iservice.IContractItemAddendumService;
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
@RequestMapping(value = "/api/contractItemAddendum")
public class ContractItemAddendumRestController {

	private final IContractItemAddendumService contractItemAddendumService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_contractItemAddendum')")
	public ResponseEntity<ContractItemAddendumDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractItemAddendumService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_contractItemAddendum')")
	public ResponseEntity<List<ContractItemAddendumDTO.Info>> list() {
		return new ResponseEntity<>(contractItemAddendumService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_contractItemAddendum')")
	public ResponseEntity<ContractItemAddendumDTO.Info> create(@Validated @RequestBody ContractItemAddendumDTO.Create request) {
		return new ResponseEntity<>(contractItemAddendumService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_contractItemAddendum')")
	public ResponseEntity<ContractItemAddendumDTO.Info> update(@RequestBody ContractItemAddendumDTO.Update request) {
		return new ResponseEntity<>(contractItemAddendumService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_contractItemAddendum')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractItemAddendumService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_contractItemAddendum')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractItemAddendumDTO.Delete request) {
		contractItemAddendumService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	// @PreAuthorize("hasAuthority('r_contractItemAddendum')")
	public ResponseEntity<ContractItemAddendumDTO.ContractItemAddendumSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractItemAddendumDTO.Info> response = contractItemAddendumService.search(request);

		final ContractItemAddendumDTO.SpecRs specResponse = new ContractItemAddendumDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractItemAddendumDTO.ContractItemAddendumSpecRs specRs = new ContractItemAddendumDTO.ContractItemAddendumSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_contractItemAddendum')")
	public ResponseEntity<SearchDTO.SearchRs<ContractItemAddendumDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractItemAddendumService.search(request), HttpStatus.OK);
	}
}
