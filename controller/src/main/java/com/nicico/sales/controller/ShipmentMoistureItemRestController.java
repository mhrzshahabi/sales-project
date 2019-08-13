package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;
import com.nicico.sales.iservice.IShipmentMoistureItemService;
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
@RequestMapping(value = "/api/shipmentMoistureItem")
public class ShipmentMoistureItemRestController {

	private final IShipmentMoistureItemService shipmentMoistureItemService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
	public ResponseEntity<ShipmentMoistureItemDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentMoistureItemService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
	public ResponseEntity<List<ShipmentMoistureItemDTO.Info>> list() {
		return new ResponseEntity<>(shipmentMoistureItemService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_shipmentMoistureItem')")
	public ResponseEntity<ShipmentMoistureItemDTO.Info> create(@Validated @RequestBody ShipmentMoistureItemDTO.Create request) {
		return new ResponseEntity<>(shipmentMoistureItemService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_shipmentMoistureItem')")
	public ResponseEntity<ShipmentMoistureItemDTO.Info> update(@RequestBody ShipmentMoistureItemDTO.Update request) {
		return new ResponseEntity<>(shipmentMoistureItemService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_shipmentMoistureItem')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentMoistureItemService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_shipmentMoistureItem')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentMoistureItemDTO.Delete request) {
		shipmentMoistureItemService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
	public ResponseEntity<ShipmentMoistureItemDTO.ShipmentMoistureItemSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentMoistureItemDTO.Info> response = shipmentMoistureItemService.search(request);

		final ShipmentMoistureItemDTO.SpecRs specResponse = new ShipmentMoistureItemDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentMoistureItemDTO.ShipmentMoistureItemSpecRs specRs = new ShipmentMoistureItemDTO.ShipmentMoistureItemSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_shipmentMoistureItem')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentMoistureItemDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentMoistureItemService.search(request), HttpStatus.OK);
	}
}
