package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PaymentOptionContractDTO;
import com.nicico.sales.iservice.IPaymentOptionContractService;
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
@RequestMapping(value = "/api/paymentOptionContract")
public class PaymentOptionContractRestController {

	private final IPaymentOptionContractService paymentOptionContractService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_paymentOptionContract')")
	public ResponseEntity<PaymentOptionContractDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(paymentOptionContractService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_paymentOptionContract')")
	public ResponseEntity<List<PaymentOptionContractDTO.Info>> list() {
		return new ResponseEntity<>(paymentOptionContractService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_paymentOptionContract')")
	public ResponseEntity<PaymentOptionContractDTO.Info> create(@Validated @RequestBody PaymentOptionContractDTO.Create request) {
		return new ResponseEntity<>(paymentOptionContractService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_paymentOptionContract')")
	public ResponseEntity<PaymentOptionContractDTO.Info> update(@RequestBody PaymentOptionContractDTO.Update request) {
		return new ResponseEntity<>(paymentOptionContractService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_paymentOptionContract')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		paymentOptionContractService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_paymentOptionContract')")
	public ResponseEntity<Void> delete(@Validated @RequestBody PaymentOptionContractDTO.Delete request) {
		paymentOptionContractService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_paymentOptionContract')")
	public ResponseEntity<PaymentOptionContractDTO.PaymentOptionContractSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<PaymentOptionContractDTO.Info> response = paymentOptionContractService.search(request);

		final PaymentOptionContractDTO.SpecRs specResponse = new PaymentOptionContractDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final PaymentOptionContractDTO.PaymentOptionContractSpecRs specRs = new PaymentOptionContractDTO.PaymentOptionContractSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_paymentOptionContract')")
	public ResponseEntity<SearchDTO.SearchRs<PaymentOptionContractDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(paymentOptionContractService.search(request), HttpStatus.OK);
	}
}
