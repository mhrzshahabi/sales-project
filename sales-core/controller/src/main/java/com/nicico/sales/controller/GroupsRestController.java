package com.nicico.sales.controller;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.GroupsDTO;
import com.nicico.sales.iservice.IGroupsService;
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
@RequestMapping(value = "/api/groups")
public class GroupsRestController {

	private final IGroupsService groupsService;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_groups')")
	public ResponseEntity<GroupsDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(groupsService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_groups')")
	public ResponseEntity<List<GroupsDTO.Info>> list() {
		return new ResponseEntity<>(groupsService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_groups')")
	public ResponseEntity<GroupsDTO.Info> create(@Validated @RequestBody GroupsDTO.Create request) {
		return new ResponseEntity<>(groupsService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_groups')")
	public ResponseEntity<GroupsDTO.Info> update(@RequestBody GroupsDTO.Update request) {
		return new ResponseEntity<>(groupsService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_groups')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		groupsService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_groups')")
	public ResponseEntity<Void> delete(@Validated @RequestBody GroupsDTO.Delete request) {
		groupsService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//	@PreAuthorize("hasAuthority('r_groups')")
	public ResponseEntity<GroupsDTO.GroupsSpecRs> list(@RequestParam("_startRow") Integer startRow, @RequestParam("_endRow") Integer endRow, @RequestParam(value = "operator", required = false) String operator, @RequestParam(value = "criteria", required = false) String criteria) {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<GroupsDTO.Info> response = groupsService.search(request);

		final GroupsDTO.SpecRs specResponse = new GroupsDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final GroupsDTO.GroupsSpecRs specRs = new GroupsDTO.GroupsSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_groups')")
	public ResponseEntity<SearchDTO.SearchRs<GroupsDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(groupsService.search(request), HttpStatus.OK);
	}
}
