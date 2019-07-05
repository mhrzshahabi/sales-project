package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ExportDTO;
import com.nicico.sales.iservice.IExportService;
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
@RequestMapping(value = "/api/export")
public class ExportRestController {

	private final IExportService exportService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('r_export')")
	public ResponseEntity<ExportDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(exportService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	@PreAuthorize("hasAuthority('r_export')")
	public ResponseEntity<List<ExportDTO.Info>> list() {
		return new ResponseEntity<>(exportService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	@PreAuthorize("hasAuthority('c_export')")
	public ResponseEntity<ExportDTO.Info> create(@Validated @RequestBody ExportDTO.Create request) {
		return new ResponseEntity<>(exportService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	@PreAuthorize("hasAuthority('u_export')")
	public ResponseEntity<ExportDTO.Info> update(@RequestBody ExportDTO.Update request) {
		return new ResponseEntity<>(exportService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	@PreAuthorize("hasAuthority('d_export')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		exportService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	@PreAuthorize("hasAuthority('d_export')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ExportDTO.Delete request) {
		exportService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	@PreAuthorize("hasAuthority('r_export')")
	public ResponseEntity<ExportDTO.ExportSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ExportDTO.Info> response = exportService.search(request);

		final ExportDTO.SpecRs specResponse = new ExportDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ExportDTO.ExportSpecRs specRs = new ExportDTO.ExportSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	@PreAuthorize("hasAuthority('r_export')")
	public ResponseEntity<SearchDTO.SearchRs<ExportDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(exportService.search(request), HttpStatus.OK);
	}
}
