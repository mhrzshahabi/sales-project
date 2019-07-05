package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.FeatureDTO;
import com.nicico.sales.iservice.IFeatureService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
//    @PreAuthorize("hasAuthority('r_feature')")
	public ResponseEntity<FeatureDTO.FeatureSpecRs> list(@RequestParam("_startRow") Integer startRow,
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

		SearchDTO.SearchRs<FeatureDTO.Info> response = featureService.search(request);

		final FeatureDTO.SpecRs specResponse = new FeatureDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final FeatureDTO.FeatureSpecRs specRs = new FeatureDTO.FeatureSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_feature')")
	public ResponseEntity<SearchDTO.SearchRs<FeatureDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(featureService.search(request), HttpStatus.OK);
	}
}
