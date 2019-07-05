package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.IncotermsDTO;
import com.nicico.sales.iservice.IIncotermsService;
import com.nicico.sales.model.entities.base.Incoterms;
import com.nicico.sales.repository.IncotermsDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class IncotermsService implements IIncotermsService {

	private final IncotermsDAO incotermsDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public IncotermsDTO.Info get(Long id) {
		final Optional<Incoterms> slById = incotermsDAO.findById(id);
		final Incoterms incoterms = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.IncotermsNotFound));

		return modelMapper.map(incoterms, IncotermsDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<IncotermsDTO.Info> list() {
		final List<Incoterms> slAll = incotermsDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<IncotermsDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public IncotermsDTO.Info create(IncotermsDTO.Create request) {
		final Incoterms incoterms = modelMapper.map(request, Incoterms.class);

		return save(incoterms);
	}

	@Transactional
	@Override
	public IncotermsDTO.Info update(Long id, IncotermsDTO.Update request) {
		final Optional<Incoterms> slById = incotermsDAO.findById(id);
		final Incoterms incoterms = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.IncotermsNotFound));

		Incoterms updating = new Incoterms();
		modelMapper.map(incoterms, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		incotermsDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(IncotermsDTO.Delete request) {
		final List<Incoterms> incotermss = incotermsDAO.findAllById(request.getIds());

		incotermsDAO.deleteAll(incotermss);
	}

	public SearchDTO.SearchRs<IncotermsDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(incotermsDAO, request, incoterms -> modelMapper.map(incoterms, IncotermsDTO.Info.class));
	}

	// ------------------------------

	private IncotermsDTO.Info save(Incoterms incoterms) {
		final Incoterms saved = incotermsDAO.saveAndFlush(incoterms);
		return modelMapper.map(saved, IncotermsDTO.Info.class);
	}
}
