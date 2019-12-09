package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractPersonDTO;
import com.nicico.sales.dto.ShipmentHeaderDTO;
import com.nicico.sales.iservice.IShipmentHeaderService;
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
@RequestMapping(value = "/api/shipmentHeader")

public class ShipmentHeaderRestController {
	private final IShipmentHeaderService shipmentHeaderService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")

	public ResponseEntity<ShipmentHeaderDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentHeaderService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")

	public ResponseEntity<List<ShipmentHeaderDTO.Info>> list() {
		return new ResponseEntity<>(shipmentHeaderService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping

	public ResponseEntity<ShipmentHeaderDTO.Info> create(@Validated @RequestBody ShipmentHeaderDTO.Create request) {
		return new ResponseEntity<>(shipmentHeaderService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping

	public ResponseEntity<ShipmentHeaderDTO.Info> update(@RequestBody ShipmentHeaderDTO.Update request) {
		return new ResponseEntity<>(shipmentHeaderService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")

	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentHeaderService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentHeaderDTO.Delete request) {
		shipmentHeaderService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}




	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<ShipmentHeaderDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(shipmentHeaderService.search(nicicoCriteria), HttpStatus.OK);
	}





	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_shipmentHeader')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentHeaderDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentHeaderService.search(request), HttpStatus.OK);
	}
}
