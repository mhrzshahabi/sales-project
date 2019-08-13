package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ParametersDTO;
import com.nicico.sales.iservice.IParametersService;
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
@RequestMapping(value = "/api/parameters")
public class ParametersRestController {

	private final IParametersService parametersService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_parameters')")
	public ResponseEntity<ParametersDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(parametersService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_parameters')")
	public ResponseEntity<List<ParametersDTO.Info>> list() {
		return new ResponseEntity<>(parametersService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_parameters')")
	public ResponseEntity<ParametersDTO.Info> create(@Validated @RequestBody ParametersDTO.Create request) {
		return new ResponseEntity<>(parametersService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_parameters')")
	public ResponseEntity<ParametersDTO.Info> update(@RequestBody ParametersDTO.Update request) {
		return new ResponseEntity<>(parametersService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_parameters')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		parametersService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_parameters')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ParametersDTO.Delete request) {
		parametersService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_parameters')")
	public ResponseEntity<ParametersDTO.ParametersSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ParametersDTO.Info> response = parametersService.search(request);

		final ParametersDTO.SpecRs specResponse = new ParametersDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ParametersDTO.ParametersSpecRs specRs = new ParametersDTO.ParametersSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_parameters')")
	public ResponseEntity<SearchDTO.SearchRs<ParametersDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(parametersService.search(request), HttpStatus.OK);
	}
}
