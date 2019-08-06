package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContractItemDTO;
import com.nicico.sales.iservice.IContractItemService;
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
@RequestMapping(value = "/api/contractItem")
public class ContractItemRestController {

	private final IContractItemService contractItemService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_contractItem')")
	public ResponseEntity<ContractItemDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractItemService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_contractItem')")
	public ResponseEntity<List<ContractItemDTO.Info>> list() {
		return new ResponseEntity<>(contractItemService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_contractItem')")
	public ResponseEntity<ContractItemDTO.Info> create(@Validated @RequestBody ContractItemDTO.Create request) {
		return new ResponseEntity<>(contractItemService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_contractItem')")
	public ResponseEntity<ContractItemDTO.Info> update(@RequestBody ContractItemDTO.Update request) {
		return new ResponseEntity<>(contractItemService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_contractItem')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractItemService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_contractItem')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractItemDTO.Delete request) {
		contractItemService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_contractItem')")
	public ResponseEntity<ContractItemDTO.ContractItemSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractItemDTO.Info> response = contractItemService.search(request);

		final ContractItemDTO.SpecRs specResponse = new ContractItemDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractItemDTO.ContractItemSpecRs specRs = new ContractItemDTO.ContractItemSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_contractItem')")
	public ResponseEntity<SearchDTO.SearchRs<ContractItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractItemService.search(request), HttpStatus.OK);
	}
}
