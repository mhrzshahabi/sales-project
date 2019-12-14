package com.nicico.sales.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.FeatureDTO;
import com.nicico.sales.iservice.IFeatureService;
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
@RequestMapping(value = "/api/feature")
public class FeatureRestController {

	private final IFeatureService featureService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_feature')")
	public ResponseEntity<FeatureDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(featureService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_feature')")
	public ResponseEntity<List<FeatureDTO.Info>> list() {
		return new ResponseEntity<>(featureService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_feature')")
	public ResponseEntity<FeatureDTO.Info> create(@Validated @RequestBody FeatureDTO.Create request) {
		return new ResponseEntity<>(featureService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
// @PreAuthorize("hasAuthority('u_feature')")
	public ResponseEntity<FeatureDTO.Info> update(@RequestBody FeatureDTO.Update request) {
		return new ResponseEntity<>(featureService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_feature')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		featureService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_feature')")
	public ResponseEntity<Void> delete(@Validated @RequestBody FeatureDTO.Delete request) {
		featureService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
	public ResponseEntity<TotalResponse<FeatureDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
		final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
		return new ResponseEntity<>(featureService.search(nicicoCriteria), HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_feature')")
	public ResponseEntity<SearchDTO.SearchRs<FeatureDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(featureService.search(request), HttpStatus.OK);
	}
}
