package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.BolItemDTO;
import com.nicico.sales.iservice.IBolItemService;
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
@RequestMapping(value = "/api/bolItem")
public class BolItemRestController {

	private final IBolItemService bolItemService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_bolItem')")
	public ResponseEntity<BolItemDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(bolItemService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_bolItem')")
	public ResponseEntity<List<BolItemDTO.Info>> list() {
		return new ResponseEntity<>(bolItemService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_bolItem')")
	public ResponseEntity<BolItemDTO.Info> create(@Validated @RequestBody BolItemDTO.Create request) {
		return new ResponseEntity<>(bolItemService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_bolItem')")
	public ResponseEntity<BolItemDTO.Info> update(@RequestBody BolItemDTO.Update request) {
		return new ResponseEntity<>(bolItemService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_bolItem')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		bolItemService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_bolItem')")
	public ResponseEntity<Void> delete(@Validated @RequestBody BolItemDTO.Delete request) {
		bolItemService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_bolItem')")
	public ResponseEntity<BolItemDTO.BolItemSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<BolItemDTO.Info> response = bolItemService.search(request);

		final BolItemDTO.SpecRs specResponse = new BolItemDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final BolItemDTO.BolItemSpecRs specRs = new BolItemDTO.BolItemSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_bolItem')")
	public ResponseEntity<SearchDTO.SearchRs<BolItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(bolItemService.search(request), HttpStatus.OK);
	}
}
