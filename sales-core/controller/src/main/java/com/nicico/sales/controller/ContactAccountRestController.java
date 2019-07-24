package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.sales.dto.ContactAccountDTO;
import com.nicico.sales.iservice.IContactAccountService;
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
@RequestMapping(value = "/api/contactAccount")
public class ContactAccountRestController {

	private final IContactAccountService contactAccountService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_contactAccount')")
	public ResponseEntity<ContactAccountDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(contactAccountService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_contactAccount')")
	public ResponseEntity<List<ContactAccountDTO.Info>> list() {
		return new ResponseEntity<>(contactAccountService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_contactAccount')")
	public ResponseEntity<ContactAccountDTO.Info> create(@Validated @RequestBody ContactAccountDTO.Create request) {
		return new ResponseEntity<>(contactAccountService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//    @PreAuthorize("hasAuthority('u_contactAccount')")
	public ResponseEntity<ContactAccountDTO.Info> update(@RequestBody ContactAccountDTO.Update request) {
		return new ResponseEntity<>(contactAccountService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_contactAccount')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		contactAccountService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_contactAccount')")
	public ResponseEntity<Void> delete(@Validated @RequestBody ContactAccountDTO.Delete request) {
		contactAccountService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_contactAccount')")
	public ResponseEntity<ContactAccountDTO.ContactAccountSpecRs> list(@RequestParam("_startRow") Integer startRow,
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
				request.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<ContactAccountDTO.Info> response = contactAccountService.search(request);

		final ContactAccountDTO.SpecRs specResponse = new ContactAccountDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final ContactAccountDTO.ContactAccountSpecRs specRs = new ContactAccountDTO.ContactAccountSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	/*@Loggable
	@GetMapping(value = "/search")
	@PreAuthorize("hasAuthority('r_contactAccount')")
	public ResponseEntity<SearchDTO.SearchRs<ContactAccountDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(contactAccountService.search(request), HttpStatus.OK);
	}

	@RequestMapping(value = {"/addAndUpdate"}, method = RequestMethod.POST)
    public @ResponseBody
    String createContact(@RequestBody String data, @RequestParam("parentId") Long parentId) {
        logger.debug("-------------------------- Add  Contact --------------------------------------");
        try {
            Gson gson = new GsonBuilder().setLenient().create();


            TblContactAccount contactAccount = gson.fromJson(data, TblContactAccount.class);

            if(contactAccount.getIsDefault()){
                TblContact one = contactService.findOne(parentId);
                one.setBankAccount(contactAccount.getBankAccount());
                one.setTblBank(contactAccount.getTblBank());
                one.setBankShaba(contactAccount.getBankShaba());
                one.setBankSwift(contactAccount.getBankSwift());
                contactService.save(one);
                unckeckOtherAccountContanctDefualtForTheContact(parentId,contactAccount.getId());
            }

            contactAccount.setContact_id(parentId);
            contactAccountService.save(contactAccount);
            checkDefaultBankInfoContact(parentId);

            return "success";
        } catch (Exception ex) {
            ex.printStackTrace();
            return "failed";
        }
    }*/
}
