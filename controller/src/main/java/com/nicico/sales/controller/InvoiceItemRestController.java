package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.iservice.IInvoiceItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/invoiceItem")
public class InvoiceItemRestController {

	private final IInvoiceItemService invoiceItemService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_invoiceItem')")
	public ResponseEntity<InvoiceItemDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(invoiceItemService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_invoiceItem')")
	public ResponseEntity<List<InvoiceItemDTO.Info>> list() {
		return new ResponseEntity<>(invoiceItemService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	// @PreAuthorize("hasAuthority('c_invoiceItem')")
	public ResponseEntity<InvoiceItemDTO.Info> create(@Validated @RequestBody InvoiceItemDTO.Create request) {
		return new ResponseEntity<>(invoiceItemService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_invoiceItem')")
	public ResponseEntity<InvoiceItemDTO.Info> update(@RequestBody InvoiceItemDTO.Update request) {
		return new ResponseEntity<>(invoiceItemService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_invoiceItem')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		invoiceItemService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_invoiceItem')")
	public ResponseEntity<Void> delete(@Validated @RequestBody InvoiceItemDTO.Delete request) {
		invoiceItemService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	// @PreAuthorize("hasAuthority('r_invoiceItem')")
	public ResponseEntity<InvoiceItemDTO.InvoiceItemSpecRs> list(@RequestParam("_startRow") Integer startRow,
														 @RequestParam("_endRow") Integer endRow,
														 @RequestParam(value = "_constructor", required = false) String constructor,
														 @RequestParam(value = "operator", required = false) String operator,
														 @RequestParam(value = "_sortBy", required = false) String sortBy,
														 @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		SearchDTO.CriteriaRq criteriaRq;
		if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
			criteria = "[" + criteria + "]";
			criteriaRq = new SearchDTO.CriteriaRq();
			criteriaRq.setOperator(EOperator.valueOf(operator))
					.setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
					}));

			if (StringUtils.isNotEmpty(sortBy)) {
				request.setSortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);
		SearchDTO.SearchRs<InvoiceItemDTO.Info> response = invoiceItemService.search(request);

		final InvoiceItemDTO.SpecRs specResponse = new InvoiceItemDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final InvoiceItemDTO.InvoiceItemSpecRs specRs = new InvoiceItemDTO.InvoiceItemSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_invoiceItem')")
	public ResponseEntity<SearchDTO.SearchRs<InvoiceItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(invoiceItemService.search(request), HttpStatus.OK);
	}
}