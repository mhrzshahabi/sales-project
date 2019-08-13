package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.LMEDTO;
import com.nicico.sales.iservice.ILMEService;
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
@RequestMapping(value = "/api/LME")
public class LMERestController {

	private final ILMEService lMEService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_LME')")
	public ResponseEntity<LMEDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(lMEService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_LME')")
	public ResponseEntity<List<LMEDTO.Info>> list() {
		return new ResponseEntity<>(lMEService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_LME')")
	public ResponseEntity<LMEDTO.Info> create(@Validated @RequestBody LMEDTO.Create request) {
		return new ResponseEntity<>(lMEService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//    @PreAuthorize("hasAuthority('u_LME')")
	public ResponseEntity<LMEDTO.Info> update(@RequestBody LMEDTO.Update request) {
		return new ResponseEntity<>(lMEService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_LME')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		lMEService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_LME')")
	public ResponseEntity<Void> delete(@Validated @RequestBody LMEDTO.Delete request) {
		lMEService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_LME')")
	public ResponseEntity<LMEDTO.LMESpecRs> list(
			@RequestParam("_startRow") Integer startRow,
			@RequestParam("_endRow") Integer endRow,
			@RequestParam(value = "operator", required = false) String operator,
			@RequestParam(value = "criteria", required = false) String criteria
	) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<LMEDTO.Info> response = lMEService.search(request);

		final LMEDTO.SpecRs specResponse = new LMEDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final LMEDTO.LMESpecRs specRs = new LMEDTO.LMESpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_LME')")
	public ResponseEntity<SearchDTO.SearchRs<LMEDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(lMEService.search(request), HttpStatus.OK);
	}
}
