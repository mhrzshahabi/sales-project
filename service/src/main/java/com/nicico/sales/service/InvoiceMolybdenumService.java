package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import com.nicico.sales.model.entities.base.InvoiceMolybdenum;
import com.nicico.sales.repository.InvoiceMolybdenumDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceMolybdenumService implements IInvoiceMolybdenumService {

	private final InvoiceMolybdenumDAO invoiceMolybdenumDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public InvoiceMolybdenumDTO.Info get(Long id) {
		final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
		final InvoiceMolybdenum invoiceMolybdenumMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

		return modelMapper.map(invoiceMolybdenumMolybdenum, InvoiceMolybdenumDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InvoiceMolybdenumDTO.Info> list() {
		final List<InvoiceMolybdenum> slAll = invoiceMolybdenumDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InvoiceMolybdenumDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InvoiceMolybdenumDTO.Info create(InvoiceMolybdenumDTO.Create request) {
		final InvoiceMolybdenum invoiceMolybdenum = modelMapper.map(request, InvoiceMolybdenum.class);

		return save(invoiceMolybdenum);
	}

	@Transactional
	@Override
	public InvoiceMolybdenumDTO.Info update(Long id, InvoiceMolybdenumDTO.Update request) {
		final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
		final InvoiceMolybdenum invoiceMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

		InvoiceMolybdenum updating = new InvoiceMolybdenum();
		modelMapper.map(invoiceMolybdenum, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		invoiceMolybdenumDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InvoiceMolybdenumDTO.Delete request) {
		final List<InvoiceMolybdenum> invoiceMolybdenums = invoiceMolybdenumDAO.findAllById(request.getIds());

		invoiceMolybdenumDAO.deleteAll(invoiceMolybdenums);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(invoiceMolybdenumDAO, request, invoiceMolybdenum -> modelMapper.map(invoiceMolybdenum, InvoiceMolybdenumDTO.Info.class));
	}

	// ------------------------------

	private InvoiceMolybdenumDTO.Info save(InvoiceMolybdenum invoiceMolybdenum) {
		final InvoiceMolybdenum saved = invoiceMolybdenumDAO.saveAndFlush(invoiceMolybdenum);
		return modelMapper.map(saved, InvoiceMolybdenumDTO.Info.class);
	}
}
