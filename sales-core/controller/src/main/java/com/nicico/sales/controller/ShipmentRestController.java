package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipment")
public class ShipmentRestController {

	private final IShipmentService shipmentService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('r_shipment')")
	public ResponseEntity<ShipmentDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(shipmentService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//@PreAuthorize("hasAuthority('r_shipment')")
	public ResponseEntity<List<ShipmentDTO.Info>> list() {
		return new ResponseEntity<>(shipmentService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//@PreAuthorize("hasAuthority('c_shipment')")
	public ResponseEntity<ShipmentDTO.Info> create(@Validated @RequestBody ShipmentDTO.Create request) {
		return new ResponseEntity<>(shipmentService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//@PreAuthorize("hasAuthority('u_shipment')")
	public ResponseEntity<ShipmentDTO.Info> update(@RequestBody ShipmentDTO.Update request) {
		Long id = request.getId();
		return new ResponseEntity<>(shipmentService.update(id, request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//@PreAuthorize("hasAuthority('d_shipment')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		shipmentService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//@PreAuthorize("hasAuthority('d_shipment')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ShipmentDTO.Delete request) {
		shipmentService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}


	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_shipment')")
	public ResponseEntity<ShipmentDTO.ShipmentSpecRs> list(@RequestParam("_startRow") Integer startRow,
														   @RequestParam("_endRow") Integer endRow,
														   @RequestParam(value = "_constructor", required = false) String constructor,
														   @RequestParam(value = "operator", required = false) String operator,
														   @RequestParam(value = "_sortBy", required = false) String sortBy,
														   @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		SearchDTO.CriteriaRq criteriaRq;
		if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
			criteria = "[" + criteria + "]";
			criteriaRq = new SearchDTO.CriteriaRq();
			criteriaRq.setOperator(EOperator.valueOf(operator))
					.setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
					}));

			if (StringUtils.isNotEmpty(sortBy)) {
				criteriaRq.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);
		SearchDTO.SearchRs<ShipmentDTO.Info> response = shipmentService.search(request);

		final ShipmentDTO.SpecRs specResponse = new ShipmentDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ShipmentDTO.ShipmentSpecRs specRs = new ShipmentDTO.ShipmentSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------
	@Loggable
	@GetMapping(value = "/pick-list")
//	@PreAuthorize("hasAuthority('r_shipment')")
	public ResponseEntity<String> pickList(@RequestParam(value = "_startRow", required = false) Integer startRow,
										   @RequestParam(value = "_endRow", required = false) Integer endRow,
										   @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		String body = "";
		if (startRow != null) {
			List<Object[]> list = shipmentService.pickListShipment();
			String[] fl = "cisId,contractNo,fullname,amount,address,plan,sendDate,duration,contactID,materialID,contractID,dischargeID,dischargeAddress".split(",");
			int totalRows = 0;
			for (Object[] rs : list) {
				String line = "";
				for (int i = 0; i < fl.length; i++)
					line += ", \"" + fl[i] + "\" : \"" + (rs[i] == null ? "" : rs[i].toString()) + "\"";
				body += ", { " + line.substring(1) + " } ";
				totalRows++;
			}
			body = "{ \"response\": {\"data\": [ " + (body.isEmpty() ? " " : body.substring(1)) + " ], \"startRow\": " + startRow + " , \"endRow\": " + endRow + " , \"totalRows\": " + totalRows + "  } } ";
		} else
			body = "{ \"response\": {\"data\": [ ], \"startRow\": 0, \"endRow\": 50 , \"totalRows\": 0  } } ";

		ResponseEntity responseEntity = new ResponseEntity(body, HttpStatus.OK);
		return responseEntity;
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//@PreAuthorize("hasAuthority('r_shipment')")
	public ResponseEntity<SearchDTO.SearchRs<ShipmentDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(shipmentService.search(request), HttpStatus.OK);
	}
}
