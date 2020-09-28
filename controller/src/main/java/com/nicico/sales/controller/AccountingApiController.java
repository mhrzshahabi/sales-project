package com.nicico.sales.controller;

import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.ICostInvoiceService;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/accounting")
public class AccountingApiController {

	private final IAccountingApiService accountingApiService;
	private final IInternalInvoiceService internalInvoiceService;
	private final ICostInvoiceService costInvoiceService;

	// ------------------------------

	/*@GetMapping(value = "/documents/{invoiceId}")
	public ResponseEntity<String> getDocumentInfo(@PathVariable String invoiceId) {
		return new ResponseEntity<>(accountingApiService.getDocumentInfo(invoiceId), HttpStatus.OK);
	}*/

	@GetMapping(value = "/departments")
	public ResponseEntity<TotalResponse<AccountingDTO.DepartmentInfo>> getAccountingDepartments() {
		final List<AccountingDTO.DepartmentInfo> departments = accountingApiService.getDepartments();

		final GridResponse<AccountingDTO.DepartmentInfo> gridResponse = new GridResponse<AccountingDTO.DepartmentInfo>()
				.setData(departments)
				.setEndRow(departments.size() - 1)
				.setStartRow(0)
				.setTotalRows(departments.size());

		return new ResponseEntity<>(new TotalResponse<>(gridResponse), HttpStatus.OK);
	}

	@PostMapping(value = "/documents/internal/{invoiceId}")
	public ResponseEntity<String> sendInternalInvoice(@PathVariable String invoiceId, @RequestBody AccountingDTO.DocumentCreateRq request) {
		return new ResponseEntity<>(internalInvoiceService.sendInvoice(invoiceId, request), HttpStatus.OK);
	}

	@PutMapping(value = "/documents/status/{systemName}")
	public ResponseEntity<Void> updateInvoiceIdsStatus(@PathVariable String systemName, @RequestBody AccountingDTO.DocumentStatusRq request) {
		internalInvoiceService.updateInvoiceIdsStatus(systemName, request);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@GetMapping(value = "/document-details")
	public ResponseEntity<TotalResponse<AccountingDTO.DocumentDetailRs>> getDocumentDetails(@RequestParam MultiValueMap<String, String> criteria) {
		final List<AccountingDTO.DocumentDetailRs> documentDetails = accountingApiService.getDetailByName(criteria);

		final GridResponse<AccountingDTO.DocumentDetailRs> gridResponse = new GridResponse<AccountingDTO.DocumentDetailRs>()
				.setData(documentDetails)
				.setEndRow(documentDetails.size() - 1)
				.setStartRow(0)
				.setTotalRows(documentDetails.size());

		return new ResponseEntity<>(new TotalResponse<>(gridResponse), HttpStatus.OK);
	}

	@PostMapping(value = "/documents/cost/{invoiceId}")
	public ResponseEntity<String> sendCostInvoice(@PathVariable Long invoiceId, @RequestBody AccountingDTO.DocumentCreateRq request) {
		return new ResponseEntity<>(costInvoiceService.sendInvoice(invoiceId, request), HttpStatus.OK);
	}
}
