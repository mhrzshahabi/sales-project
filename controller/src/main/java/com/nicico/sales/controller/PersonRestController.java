package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PersonDTO;
import com.nicico.sales.iservice.IPersonService;
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
@RequestMapping(value = "/api/person")
public class PersonRestController {

	private final IPersonService personService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_person')")
	public ResponseEntity<PersonDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(personService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_person')")
	public ResponseEntity<List<PersonDTO.Info>> list() {
		return new ResponseEntity<>(personService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_person')")
	public ResponseEntity<PersonDTO.Info> create(@Validated @RequestBody PersonDTO.Create request) {
		return new ResponseEntity<>(personService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_person')")
	public ResponseEntity<PersonDTO.Info> update(@RequestBody PersonDTO.Update request) {
		return new ResponseEntity<>(personService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_person')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		personService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_person')")
	public ResponseEntity<Void> delete(@Validated @RequestBody PersonDTO.Delete request) {
		personService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_person')")
	public ResponseEntity<PersonDTO.PersonSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<PersonDTO.Info> response = personService.search(request);

		final PersonDTO.SpecRs specResponse = new PersonDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final PersonDTO.PersonSpecRs specRs = new PersonDTO.PersonSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_person')")
	public ResponseEntity<SearchDTO.SearchRs<PersonDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(personService.search(request), HttpStatus.OK);
	}
}
