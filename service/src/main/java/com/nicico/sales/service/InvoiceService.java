package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.model.entities.base.Invoice;
import com.nicico.sales.repository.InvoiceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
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
	public InvoiceDTO.Info get(Long id) {
		final Optional<Invoice> slById = invoiceDAO.findById(id);
		final Invoice invoice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceNotFound));

		return modelMapper.map(invoice, InvoiceDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InvoiceDTO.Info> list() {
		final List<Invoice> slAll = invoiceDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InvoiceDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InvoiceDTO.Info create(InvoiceDTO.Create request) {
		final Invoice invoice = modelMapper.map(request, Invoice.class);

		return save(invoice);
	}

	@Transactional
	@Override
	public InvoiceDTO.Info update(Long id, InvoiceDTO.Update request) {
		final Optional<Invoice> slById = invoiceDAO.findById(id);
		final Invoice invoice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceNotFound));

		Invoice updating = new Invoice();
		modelMapper.map(invoice, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		invoiceDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InvoiceDTO.Delete request) {
		final List<Invoice> invoices = invoiceDAO.findAllById(request.getIds());

		invoiceDAO.deleteAll(invoices);
	}

	@Transactional
	@Override
	public InvoiceDTO.Info sendForm2accounting(Long id,String data) {
		final Invoice invoice=invoiceDAO.findById(id)
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceNotFound));
		ResponseEntity<String> processId = restTemplate.postForEntity(accountingAppUrl + "/rest/workflow/startSalesProcess", data, String.class);
		System.out.println("#### forObject = " + processId.getBody().toString());
		invoice.setProcessId(processId.getBody().toString());
		return save(invoice);

	}

	@Transactional(readOnly = true)
	@Override
	public TotalResponse<InvoiceDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(invoiceDAO, criteria, instruction -> modelMapper.map(instruction, InvoiceDTO.Info.class));
	}

	// ------------------------------

	private InvoiceDTO.Info save(Invoice invoice) {
		final Invoice saved = invoiceDAO.saveAndFlush(invoice);
		return modelMapper.map(saved, InvoiceDTO.Info.class);
	}
}
