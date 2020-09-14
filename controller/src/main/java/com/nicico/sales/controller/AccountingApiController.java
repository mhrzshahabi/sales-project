package com.nicico.sales.controller;

import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
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
	public ResponseEntity<TotalResponse> getAccountingDepartments() {
		GridResponse gridResponse = new GridResponse();
		List<AccountingDTO.DepartmentInfo> departments = accountingApiService.getDepartments();
		gridResponse.setData(departments);
		gridResponse.setEndRow(departments.size()-1);
		gridResponse.setStartRow(0);
		gridResponse.setTotalRows(departments.size());
		TotalResponse totalResponse = new TotalResponse(gridResponse);

		return new ResponseEntity<>(totalResponse, HttpStatus.OK);
	}

	@PostMapping(value = "/documents/internal/{invoiceId}")
	public ResponseEntity<String> sendInternalInvoice(@PathVariable String invoiceId, @RequestBody AccountingDTO.DocumentCreateRq request) {

		return new ResponseEntity<>(internalInvoiceService.sendInvoice(invoiceId, request),HttpStatus.OK);
	}
}
