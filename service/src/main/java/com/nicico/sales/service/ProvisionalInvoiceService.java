package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ProvisionalInvoiceDTO;
import com.nicico.sales.iservice.IProvisionalInvoiceService;
import com.nicico.sales.model.entities.base.ProvisionalInvoice;
import com.nicico.sales.repository.ProvisionalInvoiceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ProvisionalInvoiceService implements IProvisionalInvoiceService {

	private final ProvisionalInvoiceDAO provisionalInvoiceDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ProvisionalInvoiceDTO.Info get(Long id) {
		final Optional<ProvisionalInvoice> slById = provisionalInvoiceDAO.findById(id);
		final ProvisionalInvoice provisionalInvoice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ProvisionalInvoiceNotFound));

		return modelMapper.map(provisionalInvoice, ProvisionalInvoiceDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ProvisionalInvoiceDTO.Info> list() {
		final List<ProvisionalInvoice> slAll = provisionalInvoiceDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ProvisionalInvoiceDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ProvisionalInvoiceDTO.Info create(ProvisionalInvoiceDTO.Create request) {
		final ProvisionalInvoice provisionalInvoice = modelMapper.map(request, ProvisionalInvoice.class);

		return save(provisionalInvoice);
	}

	@Transactional
	@Override
	public ProvisionalInvoiceDTO.Info update(Long id, ProvisionalInvoiceDTO.Update request) {
		final Optional<ProvisionalInvoice> slById = provisionalInvoiceDAO.findById(id);
		final ProvisionalInvoice provisionalInvoice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ProvisionalInvoiceNotFound));

		ProvisionalInvoice updating = new ProvisionalInvoice();
		modelMapper.map(provisionalInvoice, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		provisionalInvoiceDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ProvisionalInvoiceDTO.Delete request) {
		final List<ProvisionalInvoice> provisionalInvoices = provisionalInvoiceDAO.findAllById(request.getIds());

		provisionalInvoiceDAO.deleteAll(provisionalInvoices);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ProvisionalInvoiceDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(provisionalInvoiceDAO, request, provisionalInvoice -> modelMapper.map(provisionalInvoice, ProvisionalInvoiceDTO.Info.class));
	}

	// ------------------------------

	private ProvisionalInvoiceDTO.Info save(ProvisionalInvoice provisionalInvoice) {
		final ProvisionalInvoice saved = provisionalInvoiceDAO.saveAndFlush(provisionalInvoice);
		return modelMapper.map(saved, ProvisionalInvoiceDTO.Info.class);
	}
}
