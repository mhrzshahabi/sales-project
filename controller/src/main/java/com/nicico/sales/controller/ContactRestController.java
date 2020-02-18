package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.iservice.IContactService;
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
@RequestMapping(value = "/api/contact")
public class ContactRestController {

    private final IContactService contactService;

    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContactDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contactService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContactDTO.Info>> list() {
        return new ResponseEntity<>(contactService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContactDTO.Info> create(@Validated @RequestBody ContactDTO.Create request) {
        String commercialRole = (request.getInspector() != null && request.getInspector().toString().equalsIgnoreCase("true") ? "Inspector," : "")
                + (request.getInsurancer() != null && request.getInsurancer().toString().equalsIgnoreCase("true") ? "Insurancer," : "")
                + (request.getShipper() != null && request.getShipper().toString().equalsIgnoreCase("true") ? "Shipper," : "")
                + (request.getTransporter() != null && request.getTransporter().toString().equalsIgnoreCase("true") ? "Transporter," : "")
                + (request.getBuyer() != null && request.getBuyer().toString().equalsIgnoreCase("true") ? "Buyer," : "")
                + (request.getSeller() != null && request.getSeller().toString().equalsIgnoreCase("true") ? "Seller," : "")
                + (request.getAgentSeller() != null && request.getAgentSeller().toString().equalsIgnoreCase("true") ? "AgentSeller," : "")
                + (request.getAgentBuyer() != null && request.getAgentBuyer().toString().equalsIgnoreCase("true") ? "Agent Buyer," : "");
        request.setCommercialRole(commercialRole.substring(0, commercialRole.length() - 1));
        return new ResponseEntity<>(contactService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContactDTO.Info> update(@RequestBody ContactDTO.Update request) {
        String commercialRole = (request.getInspector() != null && request.getInspector().toString().equalsIgnoreCase("true") ? "Inspector," : "")
                + (request.getInsurancer() != null && request.getInsurancer().toString().equalsIgnoreCase("true") ? "Insurancer," : "")
                + (request.getShipper() != null && request.getShipper().toString().equalsIgnoreCase("true") ? "Shipper," : "")
                + (request.getTransporter() != null && request.getTransporter().toString().equalsIgnoreCase("true") ? "Transporter," : "")
                + (request.getBuyer() != null && request.getBuyer().toString().equalsIgnoreCase("true") ? "Buyer," : "")
                + (request.getSeller() != null && request.getSeller().toString().equalsIgnoreCase("true") ? "Seller," : "")
                + (request.getAgentSeller() != null && request.getAgentSeller().toString().equalsIgnoreCase("true") ? "Agent Seller," : "")
                + (request.getAgentBuyer() != null && request.getAgentBuyer().toString().equalsIgnoreCase("true") ? "Agent Buyer," : "");
        request.setCommercialRole(commercialRole.substring(0, commercialRole.length() - 1));
        return new ResponseEntity<>(contactService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contactService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContactDTO.Delete request) {
        contactService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContactDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contactService.search(nicicoCriteria), HttpStatus.OK);
    }
}
