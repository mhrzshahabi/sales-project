package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ShipmentAssayItemDTO;
import com.nicico.sales.iservice.IShipmentAssayItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipmentAssayItem")
public class ShipmentAssayItemRestController {

	private final IShipmentAssayItemService shipmentAssayItemService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
	public ResponseEntity<ShipmentAssayItemDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentAssayItemService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
	public ResponseEntity<List<ShipmentAssayItemDTO.Info>> list() {
		return new ResponseEntity<>(shipmentAssayItemService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_shipmentAssayItem')")
	public ResponseEntity<ShipmentAssayItemDTO.Info> create(@Validated @RequestBody ShipmentAssayItemDTO.Create request) {
		return new ResponseEntity<>(shipmentAssayItemService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_shipmentAssayItem')")
	public ResponseEntity<ShipmentAssayItemDTO.Info> update(@RequestBody ShipmentAssayItemDTO.Update request) {
		return new ResponseEntity<>(shipmentAssayItemService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_shipmentAssayItem')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentAssayItemService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_shipmentAssayItem')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentAssayItemDTO.Delete request) {
		shipmentAssayItemService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
	public ResponseEntity<ShipmentAssayItemDTO.ShipmentAssayItemSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentAssayItemDTO.Info> response = shipmentAssayItemService.search(request);

		final ShipmentAssayItemDTO.SpecRs specResponse = new ShipmentAssayItemDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentAssayItemDTO.ShipmentAssayItemSpecRs specRs = new ShipmentAssayItemDTO.ShipmentAssayItemSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_shipmentAssayItem')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentAssayItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentAssayItemService.search(request), HttpStatus.OK);
	}
}
