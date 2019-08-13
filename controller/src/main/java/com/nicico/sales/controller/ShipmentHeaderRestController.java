package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentHeaderDTO;
import com.nicico.sales.iservice.IShipmentHeaderService;
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
@RequestMapping(value = "/api/shipmentHeader")
public class ShipmentHeaderRestController {

	private final IShipmentHeaderService shipmentHeaderService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_shipmentHeader')")
	public ResponseEntity<ShipmentHeaderDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentHeaderService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_shipmentHeader')")
	public ResponseEntity<List<ShipmentHeaderDTO.Info>> list() {
		return new ResponseEntity<>(shipmentHeaderService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	// @PreAuthorize("hasAuthority('c_shipmentHeader')")
	public ResponseEntity<ShipmentHeaderDTO.Info> create(@Validated @RequestBody ShipmentHeaderDTO.Create request) {
		return new ResponseEntity<>(shipmentHeaderService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_shipmentHeader')")
	public ResponseEntity<ShipmentHeaderDTO.Info> update(@RequestBody ShipmentHeaderDTO.Update request) {
		return new ResponseEntity<>(shipmentHeaderService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_shipmentHeader')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentHeaderService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_shipmentHeader')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentHeaderDTO.Delete request) {
		shipmentHeaderService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	// @PreAuthorize("hasAuthority('r_shipmentHeader')")
	public ResponseEntity<ShipmentHeaderDTO.ShipmentHeaderSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentHeaderDTO.Info> response = shipmentHeaderService.search(request);

		final ShipmentHeaderDTO.SpecRs specResponse = new ShipmentHeaderDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentHeaderDTO.ShipmentHeaderSpecRs specRs = new ShipmentHeaderDTO.ShipmentHeaderSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_shipmentHeader')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentHeaderDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentHeaderService.search(request), HttpStatus.OK);
	}
}
