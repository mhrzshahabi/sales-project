package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.model.entities.base.Invoice;
import com.nicico.sales.repository.InvoiceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceService implements IInvoiceService {

    private final InvoiceDAO invoiceDAO;
    private final ModelMapper modelMapper;
    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INVOICE')")
    public InvoiceDTO.Info get(Long id) {
        final Optional<Invoice> slById = invoiceDAO.findById(id);
        final Invoice invoice = slById.orElseThrow(() -> new NotFoundException(Invoice.class));

        return modelMapper.map(invoice, InvoiceDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE')")
    public List<InvoiceDTO.Info> list() {
        final List<Invoice> slAll = invoiceDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InvoiceDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_INVOICE')")
    public InvoiceDTO.Info create(InvoiceDTO.Create request) {
        final Invoice invoice = modelMapper.map(request, Invoice.class);

        return save(invoice);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_INVOICE')")
    public InvoiceDTO.Info update(Long id, InvoiceDTO.Update request) {
        final Optional<Invoice> slById = invoiceDAO.findById(id);
        final Invoice invoice = slById.orElseThrow(() -> new NotFoundException(Invoice.class));

        Invoice updating = new Invoice();
        modelMapper.map(invoice, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INVOICE')")
    public void delete(Long id) {
        invoiceDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INVOICE')")
    public void delete(InvoiceDTO.Delete request) {
        final List<Invoice> invoices = invoiceDAO.findAllById(request.getIds());

        invoiceDAO.deleteAll(invoices);
    }

    @Transactional
    @Override
    public InvoiceDTO.Info sendForm2accounting(Long id, String data) {
        final Invoice invoice = invoiceDAO.findById(id)
                .orElseThrow(() -> new NotFoundException(Invoice.class));
        ResponseEntity<String> processId = restTemplate.postForEntity(accountingAppUrl + "/rest/workflow/startSalesProcess", data, String.class);
        invoice.setProcessId(processId.getBody());
        return save(invoice);

    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE')")
    public TotalResponse<InvoiceDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(invoiceDAO, criteria, instruction -> modelMapper.map(instruction, InvoiceDTO.Info.class));
    }

    private InvoiceDTO.Info save(Invoice invoice) {
        final Invoice saved = invoiceDAO.saveAndFlush(invoice);
        return modelMapper.map(saved, InvoiceDTO.Info.class);
    }
}
