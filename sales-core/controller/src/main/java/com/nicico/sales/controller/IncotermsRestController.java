package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.IncotermsDTO;
import com.nicico.sales.iservice.IIncotermsService;
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
@RequestMapping(value = "/api/incoterms")
public class IncotermsRestController {

	private final IIncotermsService incotermsService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_incoterms')")
	public ResponseEntity<IncotermsDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(incotermsService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_incoterms')")
	public ResponseEntity<List<IncotermsDTO.Info>> list() {
		return new ResponseEntity<>(incotermsService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_incoterms')")
	public ResponseEntity<IncotermsDTO.Info> create(@Validated @RequestBody IncotermsDTO.Create request) {
		return new ResponseEntity<>(incotermsService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_incoterms')")
	public ResponseEntity<IncotermsDTO.Info> update(@RequestBody IncotermsDTO.Update request) {
		return new ResponseEntity<>(incotermsService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_incoterms')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		incotermsService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_incoterms')")
	public ResponseEntity<Void> delete(@Validated @RequestBody IncotermsDTO.Delete request) {
		incotermsService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_incoterms')")
	public ResponseEntity<IncotermsDTO.IncotermsSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<IncotermsDTO.Info> response = incotermsService.search(request);

		final IncotermsDTO.SpecRs specResponse = new IncotermsDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final IncotermsDTO.IncotermsSpecRs specRs = new IncotermsDTO.IncotermsSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_incoterms')")
	public ResponseEntity<SearchDTO.SearchRs<IncotermsDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(incotermsService.search(request), HttpStatus.OK);
	}
}
