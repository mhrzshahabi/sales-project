package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.iservice.IContractShipmentService;
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
@RequestMapping(value = "/api/contractShipment")
public class ContractShipmentRestController {

	private final IContractShipmentService contractShipmentService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_contractShipment')")
	public ResponseEntity<ContractShipmentDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractShipmentService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_contractShipment')")
	public ResponseEntity<List<ContractShipmentDTO.Info>> list() {
		return new ResponseEntity<>(contractShipmentService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_contractShipment')")
	public ResponseEntity<ContractShipmentDTO.Info> create(@Validated @RequestBody ContractShipmentDTO.Create request) {
		return new ResponseEntity<>(contractShipmentService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_contractShipment')")
	public ResponseEntity<ContractShipmentDTO.Info> update(@RequestBody ContractShipmentDTO.Update request) {
		return new ResponseEntity<>(contractShipmentService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_contractShipment')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractShipmentService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_contractShipment')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractShipmentDTO.Delete request) {
		contractShipmentService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_contractShipment')")
	public ResponseEntity<ContractShipmentDTO.ContractShipmentSpecRs> list(@RequestParam("_startRow") Integer startRow,
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

		SearchDTO.SearchRs<ContractShipmentDTO.Info> response = contractShipmentService.search(request);

		final ContractShipmentDTO.SpecRs specResponse = new ContractShipmentDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContractShipmentDTO.ContractShipmentSpecRs specRs = new ContractShipmentDTO.ContractShipmentSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_contractShipment')")
	public ResponseEntity<SearchDTO.SearchRs<ContractShipmentDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractShipmentService.search(request), HttpStatus.OK);
	}
}
