package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.RateDTO;
import com.nicico.sales.iservice.IRateService;
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
@RequestMapping(value = "/api/rate")
public class RateRestController {

	private final IRateService rateService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_rate')")
	public ResponseEntity<RateDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(rateService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_rate')")
	public ResponseEntity<List<RateDTO.Info>> list() {
		return new ResponseEntity<>(rateService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_rate')")
	public ResponseEntity<RateDTO.Info> create(@Validated @RequestBody RateDTO.Create request) {
		return new ResponseEntity<>(rateService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_rate')")
	public ResponseEntity<RateDTO.Info> update(@RequestBody RateDTO.Update request) {
		return new ResponseEntity<>(rateService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_rate')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		rateService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_rate')")
	public ResponseEntity<Void> delete(@Validated @RequestBody RateDTO.Delete request) {
		rateService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_rate')")
	public ResponseEntity<RateDTO.RateSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<RateDTO.Info> response = rateService.search(request);

		final RateDTO.SpecRs specResponse = new RateDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final RateDTO.RateSpecRs specRs = new RateDTO.RateSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_rate')")
	public ResponseEntity<SearchDTO.SearchRs<RateDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(rateService.search(request), HttpStatus.OK);
	}
}
