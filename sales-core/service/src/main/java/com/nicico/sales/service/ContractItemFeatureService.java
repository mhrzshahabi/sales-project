package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractItemFeatureDTO;
import com.nicico.sales.iservice.IContractItemFeatureService;
import com.nicico.sales.model.entities.base.ContractItemFeature;
import com.nicico.sales.repository.ContractItemFeatureDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractItemFeatureService implements IContractItemFeatureService {

	private final ContractItemFeatureDAO contractItemFeatureDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractItemFeatureDTO.Info get(Long id) {
		final Optional<ContractItemFeature> slById = contractItemFeatureDAO.findById(id);
		final ContractItemFeature contractItemFeature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemFeatureNotFound));

		return modelMapper.map(contractItemFeature, ContractItemFeatureDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractItemFeatureDTO.Info> list() {
		final List<ContractItemFeature> slAll = contractItemFeatureDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractItemFeatureDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractItemFeatureDTO.Info create(ContractItemFeatureDTO.Create request) {
		final ContractItemFeature contractItemFeature = modelMapper.map(request, ContractItemFeature.class);

		return save(contractItemFeature);
	}

	@Transactional
	@Override
	public ContractItemFeatureDTO.Info update(Long id, ContractItemFeatureDTO.Update request) {
		final Optional<ContractItemFeature> slById = contractItemFeatureDAO.findById(id);
		final ContractItemFeature contractItemFeature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemFeatureNotFound));

		ContractItemFeature updating = new ContractItemFeature();
		modelMapper.map(contractItemFeature, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractItemFeatureDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractItemFeatureDTO.Delete request) {
		final List<ContractItemFeature> contractItemFeatures = contractItemFeatureDAO.findAllById(request.getIds());

		contractItemFeatureDAO.deleteAll(contractItemFeatures);
	}

	public SearchDTO.SearchRs<ContractItemFeatureDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractItemFeatureDAO, request, contractItemFeature -> modelMapper.map(contractItemFeature, ContractItemFeatureDTO.Info.class));
	}

	// ------------------------------

	private ContractItemFeatureDTO.Info save(ContractItemFeature contractItemFeature) {
		final ContractItemFeature saved = contractItemFeatureDAO.saveAndFlush(contractItemFeature);
		return modelMapper.map(saved, ContractItemFeatureDTO.Info.class);
	}
}
