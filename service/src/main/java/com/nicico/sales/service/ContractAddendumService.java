package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractAddendumDTO;
import com.nicico.sales.iservice.IContractAddendumService;
import com.nicico.sales.model.entities.base.ContractAddendum;
import com.nicico.sales.repository.ContractAddendumDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractAddendumService implements IContractAddendumService {

	private final ContractAddendumDAO contractAddendumDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractAddendumDTO.Info get(Long id) {
		final Optional<ContractAddendum> slById = contractAddendumDAO.findById(id);
		final ContractAddendum contractAddendum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractAddendumNotFound));

		return modelMapper.map(contractAddendum, ContractAddendumDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractAddendumDTO.Info> list() {
		final List<ContractAddendum> slAll = contractAddendumDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractAddendumDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractAddendumDTO.Info create(ContractAddendumDTO.Create request) {
		final ContractAddendum contractAddendum = modelMapper.map(request, ContractAddendum.class);

		return save(contractAddendum);
	}

	@Transactional
	@Override
	public ContractAddendumDTO.Info update(Long id, ContractAddendumDTO.Update request) {
		final Optional<ContractAddendum> slById = contractAddendumDAO.findById(id);
		final ContractAddendum contractAddendum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractAddendumNotFound));

		ContractAddendum updating = new ContractAddendum();
		modelMapper.map(contractAddendum, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractAddendumDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractAddendumDTO.Delete request) {
		final List<ContractAddendum> contractAddendums = contractAddendumDAO.findAllById(request.getIds());

		contractAddendumDAO.deleteAll(contractAddendums);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractAddendumDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractAddendumDAO, request, contractAddendum -> modelMapper.map(contractAddendum, ContractAddendumDTO.Info.class));
	}

	// ------------------------------

	private ContractAddendumDTO.Info save(ContractAddendum contractAddendum) {
		final ContractAddendum saved = contractAddendumDAO.saveAndFlush(contractAddendum);
		return modelMapper.map(saved, ContractAddendumDTO.Info.class);
	}
}
