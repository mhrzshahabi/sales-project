package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ProvisionalInvoiceDTO;
import com.nicico.sales.iservice.IProvisionalInvoiceService;
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
@RequestMapping(value = "/api/provisionalInvoice")
public class ProvisionalInvoiceRestController {

	private final IProvisionalInvoiceService provisionalInvoiceService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	//	@PreAuthorize("hasAuthority('r_provisionalInvoice')")
	public ResponseEntity<ProvisionalInvoiceDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(provisionalInvoiceService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_provisionalInvoice')")
	public ResponseEntity<List<ProvisionalInvoiceDTO.Info>> list() {
		return new ResponseEntity<>(provisionalInvoiceService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_provisionalInvoice')")
	public ResponseEntity<ProvisionalInvoiceDTO.Info> create(@Validated @RequestBody ProvisionalInvoiceDTO.Create request) {
		return new ResponseEntity<>(provisionalInvoiceService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_provisionalInvoice')")
	public ResponseEntity<ProvisionalInvoiceDTO.Info> update(@RequestBody ProvisionalInvoiceDTO.Update request) {
		return new ResponseEntity<>(provisionalInvoiceService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_provisionalInvoice')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		provisionalInvoiceService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_provisionalInvoice')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ProvisionalInvoiceDTO.Delete request) {
		provisionalInvoiceService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_provisionalInvoice')")
	public ResponseEntity<ProvisionalInvoiceDTO.ProvisionalInvoiceSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ProvisionalInvoiceDTO.Info> response = provisionalInvoiceService.search(request);

		final ProvisionalInvoiceDTO.SpecRs specResponse = new ProvisionalInvoiceDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ProvisionalInvoiceDTO.ProvisionalInvoiceSpecRs specRs = new ProvisionalInvoiceDTO.ProvisionalInvoiceSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_provisionalInvoice')")
	public ResponseEntity<SearchDTO.SearchRs<ProvisionalInvoiceDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(provisionalInvoiceService.search(request), HttpStatus.OK);
	}
}
