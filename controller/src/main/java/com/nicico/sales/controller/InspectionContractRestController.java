package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.iservice.IInspectionContractService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/inspectionContract")
public class InspectionContractRestController {


	private final IInspectionContractService inspectionContractService; //What's Dif bet IInspectionContractService , InspectionContractService

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('r_inspectionContract')")
	public ResponseEntity<InspectionContractDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(inspectionContractService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('r_inspectionContract')")
	public ResponseEntity<List<InspectionContractDTO.Info>> list() {
		return new ResponseEntity<>(inspectionContractService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
	//	@PreAuthorize("hasAuthority('c_inspectionContract')")
	public ResponseEntity<InspectionContractDTO.Info> create(@Validated @RequestBody InspectionContractDTO.Create request) {
		return new ResponseEntity<>(inspectionContractService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
	//	@PreAuthorize("hasAuthority('u_inspectionContract')")
	public ResponseEntity<InspectionContractDTO.Info> update(@RequestBody InspectionContractDTO.Update request) {
		return new ResponseEntity<>(inspectionContractService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
	//	@PreAuthorize("hasAuthority('d_inspectionContract')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		inspectionContractService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
	//	@PreAuthorize("hasAuthority('d_inspectionContract')")
	public ResponseEntity<Void> delete(@Validated @RequestBody InspectionContractDTO.Delete request) {
		inspectionContractService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	//	@Loggable
//	@GetMapping(value = "/spec-list")
//	//	@PreAuthorize("hasAuthority('r_inspectionContract')")
//	public ResponseEntity<InspectionContractDTO.InspectionContractSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
//		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
//		request.setStartIndex(startRow)
//				.setCount(endRow - startRow);
//
//		SearchDTO.SearchRs<InspectionContractDTO.Info> response = inspectionContractService.search(request);
//
//		final InspectionContractDTO.SpecRs specResponse = new InspectionContractDTO.SpecRs();
//		specResponse.setData(response.getList())
//				.setStartRow(startRow)
//				.setEndRow(startRow + response.getTotalCount().intValue())
//				.setTotalRows(response.getTotalCount().intValue());
//
//		final InspectionContractDTO.InspectionContractSpecRs specRs = new InspectionContractDTO.InspectionContractSpecRs();
//		specRs.setResponse(specResponse);
//
//		return new ResponseEntity<>(specRs, HttpStatus.OK);
//	}
	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_inspectionContract')")
	public ResponseEntity<TotalResponse<InspectionContractDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) {
		TotalResponse<InspectionContractDTO.Info> search = inspectionContractService.search(criteria);
		return new ResponseEntity<TotalResponse<InspectionContractDTO.Info>>(search, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
	//	@PreAuthorize("hasAuthority('r_inspectionContract')")
	public ResponseEntity<SearchDTO.SearchRs<InspectionContractDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(inspectionContractService.search(request), HttpStatus.OK);
	}
}
