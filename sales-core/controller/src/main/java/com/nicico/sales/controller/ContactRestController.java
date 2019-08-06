package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.iservice.IContactService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contact")
public class ContactRestController {

	private final IContactService contactService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('r_contact')")
	public ResponseEntity<ContactDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contactService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//	@PreAuthorize("hasAuthority('r_contact')")
	public ResponseEntity<List<ContactDTO.Info>> list() {
		return new ResponseEntity<>(contactService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//	@PreAuthorize("hasAuthority('c_contact')")
	public ResponseEntity<ContactDTO.Info> create(@Validated @RequestBody ContactDTO.Create request) {
		request.setCommercialRole( (request.getInspector()!=null&&request.getInspector().toString().equalsIgnoreCase("true")?"بازرس , ":"")
				+(request.getInsurancer()!=null && request.getInsurancer().toString().equalsIgnoreCase("true") ?" بیمه گر ,":"")
				+(request.getShipper()!=null && request.getShipper().toString().equalsIgnoreCase("true") ?" صاحب کشتی,":"")
				+(request.getTransporter()!=null && request.getTransporter().toString().equalsIgnoreCase("true") ?" حمل کننده ,":"")
				+(request.getBuyer()!=null && request.getBuyer().toString().equalsIgnoreCase("true") ?" فروشنده ,":"")
				+(request.getSeller()!=null && request.getSeller().toString().equalsIgnoreCase("true")?" خریدار ,":"")
				+(request.getAgentSeller()!=null && request.getAgentSeller().toString().equalsIgnoreCase("true")?" نماینده فروشنده ,":"")
				+(request.getAgentBuyer()!=null && request.getAgentBuyer().toString().equalsIgnoreCase("true")?" نماینده خریدار ,":"")
		);
		return new ResponseEntity<>(contactService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//	@PreAuthorize("hasAuthority('u_contact')")
	public ResponseEntity<ContactDTO.Info> update(@RequestBody ContactDTO.Update request) {
		request.setCommercialRole( (request.getInspector()!=null&&request.getInspector().toString().equalsIgnoreCase("true")?"بازرس , ":"")
				+(request.getInsurancer()!=null && request.getInsurancer().toString().equalsIgnoreCase("true") ?" بیمه گر ,":"")
				+(request.getShipper()!=null && request.getShipper().toString().equalsIgnoreCase("true") ?" صاحب کشتی,":"")
				+(request.getTransporter()!=null && request.getTransporter().toString().equalsIgnoreCase("true") ?" حمل کننده ,":"")
				+(request.getBuyer()!=null && request.getBuyer().toString().equalsIgnoreCase("true") ?" فروشنده ,":"")
				+(request.getSeller()!=null && request.getSeller().toString().equalsIgnoreCase("true")?" خریدار ,":"")
				+(request.getAgentSeller()!=null && request.getAgentSeller().toString().equalsIgnoreCase("true")?" نماینده فروشنده ,":"")
				+(request.getAgentBuyer()!=null && request.getAgentBuyer().toString().equalsIgnoreCase("true")?" نماینده خریدار ,":"")
		);

		return new ResponseEntity<>(contactService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//	@PreAuthorize("hasAuthority('d_contact')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contactService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//	@PreAuthorize("hasAuthority('d_contact')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContactDTO.Delete request) {
		contactService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping( {"/spec-list","/spec-list1","/spec-list2","/spec-list3","/spec-list4"})
//	@PreAuthorize("hasAuthority('r_contact')")
	public ResponseEntity<ContactDTO.ContactSpecRs> list(@RequestParam(value = "_startRow", required = false) Integer startRow,
														 @RequestParam(value = "_endRow", required = false) Integer endRow,
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
				request.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		final ContactDTO.SpecRs specResponse = new ContactDTO.SpecRs();

        if (startRow != null && endRow != null) {
			request.setStartIndex(startRow)
					.setCount(endRow - startRow);

			specResponse.setStartRow(startRow)
					.setEndRow(endRow);
		}

		SearchDTO.SearchRs<ContactDTO.Info> response = contactService.search(request);

		specResponse.setData(response.getList())
				.setTotalRows(response.getTotalCount().intValue());

		final ContactDTO.ContactSpecRs specRs = new ContactDTO.ContactSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//	@PreAuthorize("hasAuthority('r_contact')")
	public ResponseEntity<SearchDTO.SearchRs<ContactDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contactService.search(request), HttpStatus.OK);
	}
}
