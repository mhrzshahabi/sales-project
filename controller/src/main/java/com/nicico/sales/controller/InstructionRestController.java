package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InstructionDTO;
import com.nicico.sales.iservice.IInstructionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
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
	public ResponseEntity<TotalResponse<InstructionDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(instructionService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_instruction')")
	public ResponseEntity<SearchDTO.SearchRs<InstructionDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(instructionService.search(request), HttpStatus.OK);
	}
}
