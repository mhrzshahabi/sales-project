package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.PaymentOptionDTO;
import com.nicico.sales.iservice.IPaymentOptionService;
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
@RequestMapping(value = "/api/paymentOption")
public class PaymentOptionRestController {

	private final IPaymentOptionService paymentOptionService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_paymentOption')")
	public ResponseEntity<PaymentOptionDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(paymentOptionService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_paymentOption')")
	public ResponseEntity<List<PaymentOptionDTO.Info>> list() {
		return new ResponseEntity<>(paymentOptionService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_paymentOption')")
	public ResponseEntity<PaymentOptionDTO.Info> create(@Validated @RequestBody PaymentOptionDTO.Create request) {
		return new ResponseEntity<>(paymentOptionService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_paymentOption')")
	public ResponseEntity<PaymentOptionDTO.Info> update(@RequestBody PaymentOptionDTO.Update request) {
		return new ResponseEntity<>(paymentOptionService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_paymentOption')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		paymentOptionService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_paymentOption')")
	public ResponseEntity<Void> delete(@Validated @RequestBody PaymentOptionDTO.Delete request) {
		paymentOptionService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_paymentOption')")
	public ResponseEntity<PaymentOptionDTO.PaymentOptionSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<PaymentOptionDTO.Info> response = paymentOptionService.search(request);

		final PaymentOptionDTO.SpecRs specResponse = new PaymentOptionDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final PaymentOptionDTO.PaymentOptionSpecRs specRs = new PaymentOptionDTO.PaymentOptionSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_paymentOption')")
	public ResponseEntity<SearchDTO.SearchRs<PaymentOptionDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(paymentOptionService.search(request), HttpStatus.OK);
	}
}
