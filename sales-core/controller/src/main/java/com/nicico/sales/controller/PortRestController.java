package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.iservice.IPortService;
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
@RequestMapping(value = "/api/port")
public class PortRestController {

	private final IPortService portService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('r_port')")
	public ResponseEntity<PortDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(portService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	@PreAuthorize("hasAuthority('r_port')")
	public ResponseEntity<List<PortDTO.Info>> list() {
		return new ResponseEntity<>(portService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	@PreAuthorize("hasAuthority('c_port')")
	public ResponseEntity<PortDTO.Info> create(@Validated @RequestBody PortDTO.Create request) {
		return new ResponseEntity<>(portService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	@PreAuthorize("hasAuthority('u_port')")
	public ResponseEntity<PortDTO.Info> update(@RequestBody PortDTO.Update request) {
		return new ResponseEntity<>(portService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('d_port')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		portService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	@PreAuthorize("hasAuthority('d_port')")
	public ResponseEntity<Void> delete(@Validated @RequestBody PortDTO.Delete request) {
		portService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping({"/spec-list", "/spec-list1", "/spec-list2", "/spec-list3"})
	@PreAuthorize("hasAuthority('r_port')")
	public ResponseEntity<PortDTO.PortSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<PortDTO.Info> response = portService.search(request);

		final PortDTO.SpecRs specResponse = new PortDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final PortDTO.PortSpecRs specRs = new PortDTO.PortSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	@PreAuthorize("hasAuthority('r_port')")
	public ResponseEntity<SearchDTO.SearchRs<PortDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(portService.search(request), HttpStatus.OK);
	}
}
