package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CurrencyRateDTO;
import com.nicico.sales.iservice.ICurrencyRateService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/currencyRate")
public class CurrencyRateRestController {

	private final ICurrencyRateService currencyRateService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_currencyRate')")
	public ResponseEntity<CurrencyRateDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(currencyRateService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_currencyRate')")
	public ResponseEntity<List<CurrencyRateDTO.Info>> list() {
		return new ResponseEntity<>(currencyRateService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_currencyRate')")
	public ResponseEntity<CurrencyRateDTO.Info> create(@Validated @RequestBody CurrencyRateDTO.Create request) {
		return new ResponseEntity<>(currencyRateService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_currencyRate')")
	public ResponseEntity<CurrencyRateDTO.Info> update(@RequestBody CurrencyRateDTO.Update request) {
		return new ResponseEntity<>(currencyRateService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_currencyRate')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		currencyRateService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_currencyRate')")
	public ResponseEntity<Void> delete(@Validated @RequestBody CurrencyRateDTO.Delete request) {
		currencyRateService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<CurrencyRateDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(currencyRateService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_currencyRate')")
	public ResponseEntity<SearchDTO.SearchRs<CurrencyRateDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(currencyRateService.search(request), HttpStatus.OK);
	}
}
