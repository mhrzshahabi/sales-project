package com.nicico.sales.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.DailyWarehouseDTO;
import com.nicico.sales.iservice.IDailyWarehouseService;
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
@RequestMapping(value = "/api/dailyWarehouse")
public class DailyWarehouseRestController {

	private final IDailyWarehouseService dailyWarehouseService;
	private final ObjectMapper objectMapper;

	@Loggable
	@GetMapping(value = "/{id}")
	public ResponseEntity<DailyWarehouseDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(dailyWarehouseService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_dailyWarehouse')")
	public ResponseEntity<List<DailyWarehouseDTO.Info>> list() {
		return new ResponseEntity<>(dailyWarehouseService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_dailyWarehouse')")
	public ResponseEntity<DailyWarehouseDTO.Info> create(@Validated @RequestBody DailyWarehouseDTO.Create request) {
		return new ResponseEntity<>(dailyWarehouseService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_dailyWarehouse')")
	public ResponseEntity<DailyWarehouseDTO.Info> update(@RequestBody DailyWarehouseDTO.Update request) {
		return new ResponseEntity<>(dailyWarehouseService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_dailyWarehouse')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		dailyWarehouseService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_dailyWarehouse')")
	public ResponseEntity<Void> delete(@Validated @RequestBody DailyWarehouseDTO.Delete request) {
		dailyWarehouseService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<DailyWarehouseDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(dailyWarehouseService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_dailyWarehouse')")
	public ResponseEntity<SearchDTO.SearchRs<DailyWarehouseDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(dailyWarehouseService.search(request), HttpStatus.OK);
	}
}
