package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractPenaltyDTO;
import com.nicico.sales.iservice.IContractPenaltyService;
import com.nicico.sales.model.entities.base.ContractPenalty;
import com.nicico.sales.repository.ContractPenaltyDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractPenaltyService implements IContractPenaltyService {

	private final ContractPenaltyDAO contractPenaltyDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractPenaltyDTO.Info get(Long id) {
		final Optional<ContractPenalty> slById = contractPenaltyDAO.findById(id);
		final ContractPenalty contractPenalty = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractPenaltyNotFound));

		return modelMapper.map(contractPenalty, ContractPenaltyDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractPenaltyDTO.Info> list() {
		final List<ContractPenalty> slAll = contractPenaltyDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractPenaltyDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractPenaltyDTO.Info create(ContractPenaltyDTO.Create request) {
		final ContractPenalty contractPenalty = modelMapper.map(request, ContractPenalty.class);

		return save(contractPenalty);
	}

	@Transactional
	@Override
	public ContractPenaltyDTO.Info update(Long id, ContractPenaltyDTO.Update request) {
		final Optional<ContractPenalty> slById = contractPenaltyDAO.findById(id);
		final ContractPenalty contractPenalty = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractPenaltyNotFound));

		ContractPenalty updating = new ContractPenalty();
		modelMapper.map(contractPenalty, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractPenaltyDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractPenaltyDTO.Delete request) {
		final List<ContractPenalty> contractPenaltys = contractPenaltyDAO.findAllById(request.getIds());

		contractPenaltyDAO.deleteAll(contractPenaltys);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractPenaltyDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractPenaltyDAO, request, contractPenalty -> modelMapper.map(contractPenalty, ContractPenaltyDTO.Info.class));
	}

	// ------------------------------

	private ContractPenaltyDTO.Info save(ContractPenalty contractPenalty) {
		final ContractPenalty saved = contractPenaltyDAO.saveAndFlush(contractPenalty);
		return modelMapper.map(saved, ContractPenaltyDTO.Info.class);
	}
}
