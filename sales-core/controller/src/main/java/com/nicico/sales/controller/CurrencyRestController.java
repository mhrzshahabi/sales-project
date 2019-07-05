package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.CurrencyDTO;
import com.nicico.sales.iservice.ICurrencyService;
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
@RequestMapping(value = "/api/currency")
public class CurrencyRestController {

	private final ICurrencyService currencyService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_currency')")
	public ResponseEntity<CurrencyDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(currencyService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_currency')")
	public ResponseEntity<List<CurrencyDTO.Info>> list() {
		return new ResponseEntity<>(currencyService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_currency')")
	public ResponseEntity<CurrencyDTO.Info> create(@Validated @RequestBody CurrencyDTO.Create request) {
		return new ResponseEntity<>(currencyService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_currency')")
	public ResponseEntity<CurrencyDTO.Info> update(@RequestBody CurrencyDTO.Update request) {
		return new ResponseEntity<>(currencyService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_currency')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		currencyService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_currency')")
	public ResponseEntity<Void> delete(@Validated @RequestBody CurrencyDTO.Delete request) {
		currencyService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_currency')")
	public ResponseEntity<CurrencyDTO.CurrencySpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<CurrencyDTO.Info> response = currencyService.search(request);

		final CurrencyDTO.SpecRs specResponse = new CurrencyDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final CurrencyDTO.CurrencySpecRs specRs = new CurrencyDTO.CurrencySpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_currency')")
	public ResponseEntity<SearchDTO.SearchRs<CurrencyDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(currencyService.search(request), HttpStatus.OK);
	}
}
