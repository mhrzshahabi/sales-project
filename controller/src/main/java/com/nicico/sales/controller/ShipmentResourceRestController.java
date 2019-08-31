package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentResourceDTO;
import com.nicico.sales.iservice.IShipmentResourceService;
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
@RequestMapping(value = "/api/shipmentResource")
public class ShipmentResourceRestController {

	private final IShipmentResourceService shipmentResourceService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	public ResponseEntity<ShipmentResourceDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentResourceService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	public ResponseEntity<List<ShipmentResourceDTO.Info>> list() {
		return new ResponseEntity<>(shipmentResourceService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	public ResponseEntity<ShipmentResourceDTO.Info> create(@Validated @RequestBody ShipmentResourceDTO.Create request) {
		return new ResponseEntity<>(shipmentResourceService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	public ResponseEntity<ShipmentResourceDTO.Info> update(@RequestBody ShipmentResourceDTO.Update request) {
		return new ResponseEntity<>(shipmentResourceService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentResourceService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentResourceDTO.Delete request) {
		shipmentResourceService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<ShipmentResourceDTO.ShipmentResourceSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentResourceDTO.Info> response = shipmentResourceService.search(request);

		final ShipmentResourceDTO.SpecRs specResponse = new ShipmentResourceDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentResourceDTO.ShipmentResourceSpecRs specRs = new ShipmentResourceDTO.ShipmentResourceSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentResourceDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentResourceService.search(request), HttpStatus.OK);
	}
}
