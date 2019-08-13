package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GlossaryDTO;
import com.nicico.sales.iservice.IGlossaryService;
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
@RequestMapping(value = "/api/glossary")
public class GlossaryRestController {

	private final IGlossaryService glossaryService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_glossary')")
	public ResponseEntity<GlossaryDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(glossaryService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_glossary')")
	public ResponseEntity<List<GlossaryDTO.Info>> list() {
		return new ResponseEntity<>(glossaryService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_glossary')")
	public ResponseEntity<GlossaryDTO.Info> create(@Validated @RequestBody GlossaryDTO.Create request) {
		return new ResponseEntity<>(glossaryService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_glossary')")
	public ResponseEntity<GlossaryDTO.Info> update(@RequestBody GlossaryDTO.Update request) {
		return new ResponseEntity<>(glossaryService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_glossary')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		glossaryService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_glossary')")
	public ResponseEntity<Void> delete(@Validated @RequestBody GlossaryDTO.Delete request) {
		glossaryService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_glossary')")
	public ResponseEntity<GlossaryDTO.GlossarySpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<GlossaryDTO.Info> response = glossaryService.search(request);

		final GlossaryDTO.SpecRs specResponse = new GlossaryDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final GlossaryDTO.GlossarySpecRs specRs = new GlossaryDTO.GlossarySpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_glossary')")
	public ResponseEntity<SearchDTO.SearchRs<GlossaryDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(glossaryService.search(request), HttpStatus.OK);
	}
}
