package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContractAttachmentDTO;
import com.nicico.sales.iservice.IContractAttachmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractAttachment")
public class ContractAttachmentRestController {

	private final IContractAttachmentService contractAttachmentService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_contractAttachment')")
	public ResponseEntity<ContractAttachmentDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractAttachmentService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_contractAttachment')")
	public ResponseEntity<List<ContractAttachmentDTO.Info>> list() {
		return new ResponseEntity<>(contractAttachmentService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_contractAttachment')")
	public ResponseEntity<ContractAttachmentDTO.Info> create(@Validated @RequestBody ContractAttachmentDTO.Create request) {
		return new ResponseEntity<>(contractAttachmentService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_contractAttachment')")
	public ResponseEntity<ContractAttachmentDTO.Info> update(@RequestBody ContractAttachmentDTO.Update request) {
		return new ResponseEntity<>(contractAttachmentService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_contractAttachment')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractAttachmentService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_contractAttachment')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractAttachmentDTO.Delete request) {
		contractAttachmentService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_contractAttachment')")
	public ResponseEntity<ContractAttachmentDTO.ContractAttachmentSpecRs> list(@RequestParam("_startRow") Integer startRow,
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
				request.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);


		SearchDTO.SearchRs<ContractAttachmentDTO.Info> response = contractAttachmentService.search(request);

		final ContractAttachmentDTO.SpecRs specResponse = new ContractAttachmentDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractAttachmentDTO.ContractAttachmentSpecRs specRs = new ContractAttachmentDTO.ContractAttachmentSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_contractAttachment')")
	public ResponseEntity<SearchDTO.SearchRs<ContractAttachmentDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractAttachmentService.search(request), HttpStatus.OK);
	}
}
