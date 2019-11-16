package com.nicico.sales.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseLotDTO;
import com.nicico.sales.iservice.IWarehouseLotService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/warehouseLot")
public class WarehouseLotRestController {

	private final IWarehouseLotService warehouseLotService;
	private final ObjectMapper objectMapper;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_warehouseLot')")
	public ResponseEntity<WarehouseLotDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(warehouseLotService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_warehouseLot')")
	public ResponseEntity<List<WarehouseLotDTO.Info>> list() {
		return new ResponseEntity<>(warehouseLotService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	public ResponseEntity<WarehouseLotDTO.Info> create(@Validated @RequestBody WarehouseLotDTO.Create request) {
		return new ResponseEntity<>(warehouseLotService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_warehouseLot')")
	public ResponseEntity<WarehouseLotDTO.Info> update(@RequestBody WarehouseLotDTO.Update request) {
		return new ResponseEntity<>(warehouseLotService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_warehouseLot')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		warehouseLotService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_warehouseLot')")
	public ResponseEntity<Void> delete(@Validated @RequestBody WarehouseLotDTO.Delete request) {
		warehouseLotService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<TotalResponse<WarehouseLotDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(warehouseLotService.search(nicicoCriteria), HttpStatus.OK);
	}


	// ------------------------------

}


