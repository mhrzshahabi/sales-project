package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractItemAddendumDTO;
import com.nicico.sales.iservice.IContractItemAddendumService;
import com.nicico.sales.model.entities.base.ContractItemAddendum;
import com.nicico.sales.repository.ContractItemAddendumDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractItemAddendumService implements IContractItemAddendumService {

	private final ContractItemAddendumDAO contractItemAddendumDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractItemAddendumDTO.Info get(Long id) {
		final Optional<ContractItemAddendum> slById = contractItemAddendumDAO.findById(id);
		final ContractItemAddendum contractItemAddendum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemAddendumNotFound));

		return modelMapper.map(contractItemAddendum, ContractItemAddendumDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractItemAddendumDTO.Info> list() {
		final List<ContractItemAddendum> slAll = contractItemAddendumDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractItemAddendumDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractItemAddendumDTO.Info create(ContractItemAddendumDTO.Create request) {
		final ContractItemAddendum contractItemAddendum = modelMapper.map(request, ContractItemAddendum.class);

		return save(contractItemAddendum);
	}

	@Transactional
	@Override
	public ContractItemAddendumDTO.Info update(Long id, ContractItemAddendumDTO.Update request) {
		final Optional<ContractItemAddendum> slById = contractItemAddendumDAO.findById(id);
		final ContractItemAddendum contractItemAddendum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemAddendumNotFound));

		ContractItemAddendum updating = new ContractItemAddendum();
		modelMapper.map(contractItemAddendum, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractItemAddendumDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractItemAddendumDTO.Delete request) {
		final List<ContractItemAddendum> contractItemAddendums = contractItemAddendumDAO.findAllById(request.getIds());

		contractItemAddendumDAO.deleteAll(contractItemAddendums);
	}

	public SearchDTO.SearchRs<ContractItemAddendumDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractItemAddendumDAO, request, contractItemAddendum -> modelMapper.map(contractItemAddendum, ContractItemAddendumDTO.Info.class));
	}

	// ------------------------------

	private ContractItemAddendumDTO.Info save(ContractItemAddendum contractItemAddendum) {
		final ContractItemAddendum saved = contractItemAddendumDAO.saveAndFlush(contractItemAddendum);
		return modelMapper.map(saved, ContractItemAddendumDTO.Info.class);
	}
}
