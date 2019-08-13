package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentEmailDTO;
import com.nicico.sales.iservice.IShipmentEmailService;
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
@RequestMapping(value = "/api/shipmentEmail")
public class ShipmentEmailRestController {

	private final IShipmentEmailService shipmentEmailService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_shipmentEmail')")
	public ResponseEntity<ShipmentEmailDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentEmailService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_shipmentEmail')")
	public ResponseEntity<List<ShipmentEmailDTO.Info>> list() {
		return new ResponseEntity<>(shipmentEmailService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_shipmentEmail')")
	public ResponseEntity<ShipmentEmailDTO.Info> create(@Validated @RequestBody ShipmentEmailDTO.Create request) {
		return new ResponseEntity<>(shipmentEmailService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_shipmentEmail')")
	public ResponseEntity<ShipmentEmailDTO.Info> update(@RequestBody ShipmentEmailDTO.Update request) {
		return new ResponseEntity<>(shipmentEmailService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_shipmentEmail')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentEmailService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//@PreAuthorize("hasAuthority('d_shipmentEmail')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentEmailDTO.Delete request) {
		shipmentEmailService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_shipmentEmail')")
	public ResponseEntity<ShipmentEmailDTO.ShipmentEmailSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentEmailDTO.Info> response = shipmentEmailService.search(request);

		final ShipmentEmailDTO.SpecRs specResponse = new ShipmentEmailDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentEmailDTO.ShipmentEmailSpecRs specRs = new ShipmentEmailDTO.ShipmentEmailSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_shipmentEmail')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentEmailDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentEmailService.search(request), HttpStatus.OK);
	}
}
