package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractPenaltyDTO;
import com.nicico.sales.iservice.IContractPenaltyService;
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
@RequestMapping(value = "/api/contractPenalty")
public class ContractPenaltyRestController {

	private final IContractPenaltyService contractPenaltyService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_contractPenalty')")
	public ResponseEntity<ContractPenaltyDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractPenaltyService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_contractPenalty')")
	public ResponseEntity<List<ContractPenaltyDTO.Info>> list() {
		return new ResponseEntity<>(contractPenaltyService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_contractPenalty')")
	public ResponseEntity<ContractPenaltyDTO.Info> create(@Validated @RequestBody ContractPenaltyDTO.Create request) {
		return new ResponseEntity<>(contractPenaltyService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_contractPenalty')")
	public ResponseEntity<ContractPenaltyDTO.Info> update(@RequestBody ContractPenaltyDTO.Update request) {
		return new ResponseEntity<>(contractPenaltyService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_contractPenalty')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractPenaltyService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_contractPenalty')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractPenaltyDTO.Delete request) {
		contractPenaltyService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_contractPenalty')")
	public ResponseEntity<ContractPenaltyDTO.ContractPenaltySpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractPenaltyDTO.Info> response = contractPenaltyService.search(request);

		final ContractPenaltyDTO.SpecRs specResponse = new ContractPenaltyDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractPenaltyDTO.ContractPenaltySpecRs specRs = new ContractPenaltyDTO.ContractPenaltySpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_contractPenalty')")
	public ResponseEntity<SearchDTO.SearchRs<ContractPenaltyDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractPenaltyService.search(request), HttpStatus.OK);
	}
}
