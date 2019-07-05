package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.InstructionDTO;
import com.nicico.sales.iservice.IInstructionService;
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
@RequestMapping(value = "/api/instruction")
public class InstructionRestController {

	private final IInstructionService instructionService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<InstructionDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(instructionService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<List<InstructionDTO.Info>> list() {
		return new ResponseEntity<>(instructionService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_instruction')")
	public ResponseEntity<InstructionDTO.Info> create(@Validated @RequestBody InstructionDTO.Create request) {
		return new ResponseEntity<>(instructionService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_instruction')")
	public ResponseEntity<InstructionDTO.Info> update(@RequestBody InstructionDTO.Update request) {
		return new ResponseEntity<>(instructionService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_instruction')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		instructionService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_instruction')")
	public ResponseEntity<Void> delete(@Validated @RequestBody InstructionDTO.Delete request) {
		instructionService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<InstructionDTO.InstructionSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<InstructionDTO.Info> response = instructionService.search(request);

		final InstructionDTO.SpecRs specResponse = new InstructionDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final InstructionDTO.InstructionSpecRs specRs = new InstructionDTO.InstructionSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<SearchDTO.SearchRs<InstructionDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(instructionService.search(request), HttpStatus.OK);
	}
}
