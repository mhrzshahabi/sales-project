package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.BolHeaderDTO;
import com.nicico.sales.iservice.IBolHeaderService;
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
@RequestMapping(value = "/api/bolHeader")
public class BolHeaderRestController {

	private final IBolHeaderService bolHeaderService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_bolHeader')")
	public ResponseEntity<BolHeaderDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(bolHeaderService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_bolHeader')")
	public ResponseEntity<List<BolHeaderDTO.Info>> list() {
		return new ResponseEntity<>(bolHeaderService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_bolHeader')")
	public ResponseEntity<BolHeaderDTO.Info> create(@Validated @RequestBody BolHeaderDTO.Create request) {
		return new ResponseEntity<>(bolHeaderService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_bolHeader')")
	public ResponseEntity<BolHeaderDTO.Info> update(@RequestBody BolHeaderDTO.Update request) {
		return new ResponseEntity<>(bolHeaderService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_bolHeader')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		bolHeaderService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_bolHeader')")
	public ResponseEntity<Void> delete(@Validated @RequestBody BolHeaderDTO.Delete request) {
		bolHeaderService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_bolHeader')")
	public ResponseEntity<BolHeaderDTO.BolHeaderSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<BolHeaderDTO.Info> response = bolHeaderService.search(request);

		final BolHeaderDTO.SpecRs specResponse = new BolHeaderDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final BolHeaderDTO.BolHeaderSpecRs specRs = new BolHeaderDTO.BolHeaderSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_bolHeader')")
	public ResponseEntity<SearchDTO.SearchRs<BolHeaderDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(bolHeaderService.search(request), HttpStatus.OK);
	}
}
