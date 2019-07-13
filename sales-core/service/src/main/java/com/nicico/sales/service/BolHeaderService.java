package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.BolHeaderDTO;
import com.nicico.sales.iservice.IBolHeaderService;
import com.nicico.sales.model.entities.base.BolHeader;
import com.nicico.sales.repository.BolHeaderDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class BolHeaderService implements IBolHeaderService {

	private final BolHeaderDAO bolHeaderDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public BolHeaderDTO.Info get(Long id) {
		final Optional<BolHeader> slById = bolHeaderDAO.findById(id);
		final BolHeader bolHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BolHeaderNotFound));

		return modelMapper.map(bolHeader, BolHeaderDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<BolHeaderDTO.Info> list() {
		final List<BolHeader> slAll = bolHeaderDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<BolHeaderDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public BolHeaderDTO.Info create(BolHeaderDTO.Create request) {
		final BolHeader bolHeader = modelMapper.map(request, BolHeader.class);

		return save(bolHeader);
	}

	@Transactional
	@Override
	public BolHeaderDTO.Info update(Long id, BolHeaderDTO.Update request) {
		final Optional<BolHeader> slById = bolHeaderDAO.findById(id);
		final BolHeader bolHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BolHeaderNotFound));

		BolHeader updating = new BolHeader();
		modelMapper.map(bolHeader, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		bolHeaderDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(BolHeaderDTO.Delete request) {
		final List<BolHeader> bolHeaders = bolHeaderDAO.findAllById(request.getIds());

		bolHeaderDAO.deleteAll(bolHeaders);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<BolHeaderDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(bolHeaderDAO, request, bolHeader -> modelMapper.map(bolHeader, BolHeaderDTO.Info.class));
	}

	// ------------------------------

	private BolHeaderDTO.Info save(BolHeader bolHeader) {
		final BolHeader saved = bolHeaderDAO.saveAndFlush(bolHeader);
		return modelMapper.map(saved, BolHeaderDTO.Info.class);
	}
}
