package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractAddendumDTO;
import com.nicico.sales.iservice.IContractAddendumService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractAddendum")
public class ContractAddendumRestController {

	private final IContractAddendumService contractAddendumService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_contractAddendum')")
	public ResponseEntity<ContractAddendumDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contractAddendumService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_contractAddendum')")
	public ResponseEntity<List<ContractAddendumDTO.Info>> list() {
		return new ResponseEntity<>(contractAddendumService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_contractAddendum')")
	public ResponseEntity<ContractAddendumDTO.Info> create(@Validated @RequestBody ContractAddendumDTO.Create request) {
		return new ResponseEntity<>(contractAddendumService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_contractAddendum')")
	public ResponseEntity<ContractAddendumDTO.Info> update(@RequestBody ContractAddendumDTO.Update request) {
		return new ResponseEntity<>(contractAddendumService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_contractAddendum')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contractAddendumService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_contractAddendum')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContractAddendumDTO.Delete request) {
		contractAddendumService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<ContractAddendumDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(contractAddendumService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_contractAddendum')")
	public ResponseEntity<SearchDTO.SearchRs<ContractAddendumDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contractAddendumService.search(request), HttpStatus.OK);
	}
}
