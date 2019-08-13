package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractItemShipmentDTO;
import com.nicico.sales.iservice.IContractItemShipmentService;
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
@RequestMapping(value = "/api/contractItemShipment")
public class ContractItemShipmentRestController {

	private final IContractItemShipmentService contractItemShipmentService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_contractItemShipment')")
	public ResponseEntity<ContractItemShipmentDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractItemShipmentService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_contractItemShipment')")
	public ResponseEntity<List<ContractItemShipmentDTO.Info>> list() {
		return new ResponseEntity<>(contractItemShipmentService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_contractItemShipment')")
	public ResponseEntity<ContractItemShipmentDTO.Info> create(@Validated @RequestBody ContractItemShipmentDTO.Create request) {
		return new ResponseEntity<>(contractItemShipmentService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_contractItemShipment')")
	public ResponseEntity<ContractItemShipmentDTO.Info> update(@RequestBody ContractItemShipmentDTO.Update request) {
		return new ResponseEntity<>(contractItemShipmentService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_contractItemShipment')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractItemShipmentService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//@PreAuthorize("hasAuthority('d_contractItemShipment')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractItemShipmentDTO.Delete request) {
		contractItemShipmentService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//@PreAuthorize("hasAuthority('r_contractItemShipment')")
	public ResponseEntity<ContractItemShipmentDTO.ContractItemShipmentSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContractItemShipmentDTO.Info> response = contractItemShipmentService.search(request);

		final ContractItemShipmentDTO.SpecRs specResponse = new ContractItemShipmentDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractItemShipmentDTO.ContractItemShipmentSpecRs specRs = new ContractItemShipmentDTO.ContractItemShipmentSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//@PreAuthorize("hasAuthority('r_contractItemShipment')")
	public ResponseEntity<SearchDTO.SearchRs<ContractItemShipmentDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractItemShipmentService.search(request), HttpStatus.OK);
	}
}
