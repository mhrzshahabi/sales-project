package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.oauth.common.repository.OAUserDAO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceInternalLcDTO;
import com.nicico.sales.iservice.IInvoiceInternalLcService;
import com.nicico.sales.model.entities.base.InvoiceInternalLc;
import com.nicico.sales.repository.InvoiceInternalLcDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceInternalLcService implements IInvoiceInternalLcService {

	private final ModelMapper modelMapper;
	private final ObjectMapper objectMapper;
	private final InvoiceInternalLcDAO invoiceInternalLcDAO;
	private final OAUserDAO oaUserDAO;

	private final OAuth2RestTemplate restTemplate;

	@Value("${nicico.apps.accounting}")
	private String accountingAppUrl;


	@Transactional(readOnly = true)
	public InvoiceInternalLcDTO.Info get(Long id) {
		final InvoiceInternalLc invoiceInternalLc = invoiceInternalLcDAO.findById(id)
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceInternalLcNotFound));

		return modelMapper.map(invoiceInternalLc, InvoiceInternalLcDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InvoiceInternalLcDTO.Info> list() {
		final List<InvoiceInternalLc> slAll = invoiceInternalLcDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InvoiceInternalLcDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InvoiceInternalLcDTO.Info create(InvoiceInternalLcDTO.Create request) {
		final InvoiceInternalLc invoiceInternalLc = modelMapper.map(request, InvoiceInternalLc.class);

		final Optional<InvoiceInternalLc> invoiceInternalLc1 = invoiceInternalLcDAO.findById(request.getId());
		if (invoiceInternalLc != null)
			throw new SalesException(SalesException.ErrorType.DuplicateRecord);

		return save(invoiceInternalLc);
	}

	@Transactional
	@Override
	public InvoiceInternalLcDTO.Info update(Long id, InvoiceInternalLcDTO.Update request) {
		final InvoiceInternalLc invoiceInternalLc = invoiceInternalLcDAO.findById(id)
				.orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

		InvoiceInternalLc updating = new InvoiceInternalLc();
		modelMapper.map(invoiceInternalLc, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		invoiceInternalLcDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InvoiceInternalLcDTO.Delete request) {
		final List<InvoiceInternalLc> indices = invoiceInternalLcDAO.findAllById(request.getIds());

		invoiceInternalLcDAO.deleteAll(indices);
	}

	@Transactional(readOnly = true)
	@Override
	public TotalResponse<InvoiceInternalLcDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(invoiceInternalLcDAO, criteria, invoiceInternalLc -> modelMapper.map(invoiceInternalLc, InvoiceInternalLcDTO.Info.class));
	}


	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InvoiceInternalLcDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(invoiceInternalLcDAO, request, invoiceInternalLc -> modelMapper.map(invoiceInternalLc, InvoiceInternalLcDTO.Info.class));
	}



	private InvoiceInternalLcDTO.Info save(InvoiceInternalLc invoiceInternalLc) {

		final InvoiceInternalLc saved = invoiceInternalLcDAO.saveAndFlush(invoiceInternalLc);
		return modelMapper.map(saved, InvoiceInternalLcDTO.Info.class);
	}
}
