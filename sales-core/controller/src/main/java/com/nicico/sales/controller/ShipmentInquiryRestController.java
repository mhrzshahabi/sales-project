package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ShipmentInquiryDTO;
import com.nicico.sales.iservice.IShipmentInquiryService;
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
@RequestMapping(value = "/api/shipmentInquiry")
public class ShipmentInquiryRestController {

	private final IShipmentInquiryService shipmentInquiryService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_shipmentInquiry')")
	public ResponseEntity<ShipmentInquiryDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentInquiryService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_shipmentInquiry')")
	public ResponseEntity<List<ShipmentInquiryDTO.Info>> list() {
		return new ResponseEntity<>(shipmentInquiryService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_shipmentInquiry')")
	public ResponseEntity<ShipmentInquiryDTO.Info> create(@Validated @RequestBody ShipmentInquiryDTO.Create request) {
		return new ResponseEntity<>(shipmentInquiryService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_shipmentInquiry')")
	public ResponseEntity<ShipmentInquiryDTO.Info> update(@RequestBody ShipmentInquiryDTO.Update request) {
		return new ResponseEntity<>(shipmentInquiryService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_shipmentInquiry')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentInquiryService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//@PreAuthorize("hasAuthority('d_shipmentInquiry')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentInquiryDTO.Delete request) {
		shipmentInquiryService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	//@PreAuthorize("hasAuthority('r_shipmentInquiry')")
	public ResponseEntity<ShipmentInquiryDTO.ShipmentInquirySpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ShipmentInquiryDTO.Info> response = shipmentInquiryService.search(request);

		final ShipmentInquiryDTO.SpecRs specResponse = new ShipmentInquiryDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentInquiryDTO.ShipmentInquirySpecRs specRs = new ShipmentInquiryDTO.ShipmentInquirySpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//@PreAuthorize("hasAuthority('r_shipmentInquiry')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentInquiryDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentInquiryService.search(request), HttpStatus.OK);
	}
}
