package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ShipmentPriceDTO;
import com.nicico.sales.iservice.IShipmentPriceService;
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
@RequestMapping(value = "/api/shipmentPrice")
public class ShipmentPriceRestController {

	private final IShipmentPriceService shipmentPriceService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('r_shipmentPrice')")
	public ResponseEntity<ShipmentPriceDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentPriceService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	// @PreAuthorize("hasAuthority('r_shipmentPrice')")
	public ResponseEntity<List<ShipmentPriceDTO.Info>> list() {
		return new ResponseEntity<>(shipmentPriceService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	// @PreAuthorize("hasAuthority('c_shipmentPrice')")
	public ResponseEntity<ShipmentPriceDTO.Info> create(@Validated @RequestBody ShipmentPriceDTO.Create request) {
		return new ResponseEntity<>(shipmentPriceService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	// @PreAuthorize("hasAuthority('u_shipmentPrice')")
	public ResponseEntity<ShipmentPriceDTO.Info> update(@RequestBody ShipmentPriceDTO.Update request) {
		return new ResponseEntity<>(shipmentPriceService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	// @PreAuthorize("hasAuthority('d_shipmentPrice')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentPriceService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	// @PreAuthorize("hasAuthority('d_shipmentPrice')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentPriceDTO.Delete request) {
		shipmentPriceService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	// @PreAuthorize("hasAuthority('r_shipmentPrice')")
	public ResponseEntity<ShipmentPriceDTO.ShipmentPriceSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentPriceDTO.Info> response = shipmentPriceService.search(request);

		final ShipmentPriceDTO.SpecRs specResponse = new ShipmentPriceDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentPriceDTO.ShipmentPriceSpecRs specRs = new ShipmentPriceDTO.ShipmentPriceSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	// @PreAuthorize("hasAuthority('r_shipmentPrice')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentPriceDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentPriceService.search(request), HttpStatus.OK);
	}
}
