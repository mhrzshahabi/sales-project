package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContractItemFeatureDTO;
import com.nicico.sales.iservice.IContractItemFeatureService;
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
@RequestMapping(value = "/api/contractItemFeature")
public class ContractItemFeatureRestController {

	private final IContractItemFeatureService contractItemFeatureService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_contractItemFeature')")
	public ResponseEntity<ContractItemFeatureDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractItemFeatureService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_contractItemFeature')")
	public ResponseEntity<List<ContractItemFeatureDTO.Info>> list() {
		return new ResponseEntity<>(contractItemFeatureService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_contractItemFeature')")
	public ResponseEntity<ContractItemFeatureDTO.Info> create(@Validated @RequestBody ContractItemFeatureDTO.Create request) {
		return new ResponseEntity<>(contractItemFeatureService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_contractItemFeature')")
	public ResponseEntity<ContractItemFeatureDTO.Info> update(@RequestBody ContractItemFeatureDTO.Update request) {
		return new ResponseEntity<>(contractItemFeatureService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_contractItemFeature')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractItemFeatureService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//@PreAuthorize("hasAuthority('d_contractItemFeature')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractItemFeatureDTO.Delete request) {
		contractItemFeatureService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//@PreAuthorize("hasAuthority('r_contractItemFeature')")
	public ResponseEntity<ContractItemFeatureDTO.ContractItemFeatureSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractItemFeatureDTO.Info> response = contractItemFeatureService.search(request);

		final ContractItemFeatureDTO.SpecRs specResponse = new ContractItemFeatureDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractItemFeatureDTO.ContractItemFeatureSpecRs specRs = new ContractItemFeatureDTO.ContractItemFeatureSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//@PreAuthorize("hasAuthority('r_contractItemFeature')")
	public ResponseEntity<SearchDTO.SearchRs<ContractItemFeatureDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractItemFeatureService.search(request), HttpStatus.OK);
	}
}
