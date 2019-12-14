package com.nicico.sales.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/invoiceMolybdenum")
public class InvoiceMolybdenumRestController {

	private final IInvoiceMolybdenumService invoiceMolybdenumService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_invoiceMolybdenum')")
	public ResponseEntity<InvoiceMolybdenumDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(invoiceMolybdenumService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_invoiceMolybdenum')")
	public ResponseEntity<List<InvoiceMolybdenumDTO.Info>> list() {
		return new ResponseEntity<>(invoiceMolybdenumService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	// @PreAuthorize("hasAuthority('c_invoiceMolybdenum')")
	public ResponseEntity<InvoiceMolybdenumDTO.Info> create(@Validated @RequestBody InvoiceMolybdenumDTO.Create request) {
		return new ResponseEntity<>(invoiceMolybdenumService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_invoiceMolybdenum')")
	public ResponseEntity<InvoiceMolybdenumDTO.Info> update(@RequestBody InvoiceMolybdenumDTO.Update request) {
		return new ResponseEntity<>(invoiceMolybdenumService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_invoiceMolybdenum')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		invoiceMolybdenumService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_invoiceMolybdenum')")
	public ResponseEntity<Void> delete(@Validated @RequestBody InvoiceMolybdenumDTO.Delete request) {
		invoiceMolybdenumService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<TotalResponse<InvoiceMolybdenumDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(invoiceMolybdenumService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_invoiceMolybdenum')")
	public ResponseEntity<SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(invoiceMolybdenumService.search(request), HttpStatus.OK);
	}
}
