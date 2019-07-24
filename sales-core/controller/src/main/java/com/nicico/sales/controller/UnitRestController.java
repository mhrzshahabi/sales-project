package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
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
@RequestMapping(value = "/api/unit")
public class UnitRestController {

	private final IUnitService unitService;
	private final ObjectMapper objectMapper;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_unit')")
	public ResponseEntity<UnitDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(unitService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_unit')")
	public ResponseEntity<List<UnitDTO.Info>> list() {
		return new ResponseEntity<>(unitService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_unit')")
	public ResponseEntity<UnitDTO.Info> create(@Validated @RequestBody UnitDTO.Create request) {
		return new ResponseEntity<>(unitService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//    @PreAuthorize("hasAuthority('u_unit')")
	public ResponseEntity<UnitDTO.Info> update(@RequestBody UnitDTO.Update request) {
		return new ResponseEntity<>(unitService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_unit')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		unitService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_unit')")
	public ResponseEntity<Void> delete(@Validated @RequestBody UnitDTO.Delete request) {
		unitService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_unit')")

	public ResponseEntity<UnitDTO.UnitSpecRs> list(@RequestParam("_startRow") Integer startRow,
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

		SearchDTO.SearchRs<UnitDTO.Info> response = unitService.search(request);

		final UnitDTO.SpecRs specResponse = new UnitDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final UnitDTO.UnitSpecRs specRs = new UnitDTO.UnitSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_unit')")
	public ResponseEntity<SearchDTO.SearchRs<UnitDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(unitService.search(request), HttpStatus.OK);
	}
}
