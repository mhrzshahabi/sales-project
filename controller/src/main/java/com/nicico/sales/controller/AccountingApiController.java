package com.nicico.sales.controller;

import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/accounting")
public class AccountingApiController {

	private final IAccountingApiService accountingApiService;
	private final IInternalInvoiceService internalInvoiceService;

	// ------------------------------

	@GetMapping(value = "/documents/{invoiceId}")
	public ResponseEntity<String> getDocumentInfo(@PathVariable String invoiceId) {
		return new ResponseEntity<>(accountingApiService.getDocumentInfo(invoiceId), HttpStatus.OK);
	}

	@GetMapping(value = "/departments")
	public ResponseEntity<List<AccountingDTO.DepartmentInfo>> getAccountingDepartments() {
		return new ResponseEntity<>(accountingApiService.getDepartments(), HttpStatus.OK);
	}

	@PostMapping(value = "/documents/internal/{invoiceId}")
	public ResponseEntity<Void> sendInternalInvoice(@PathVariable String invoiceId, @RequestBody AccountingDTO.DocumentCreateRq request) {
		internalInvoiceService.sendInvoice(invoiceId, request);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
