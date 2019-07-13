package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractItemDTO;
import com.nicico.sales.iservice.IContractItemService;
import com.nicico.sales.model.entities.base.ContractItem;
import com.nicico.sales.repository.ContractItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractItemService implements IContractItemService {

	private final ContractItemDAO contractItemDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractItemDTO.Info get(Long id) {
		final Optional<ContractItem> slById = contractItemDAO.findById(id);
		final ContractItem contractItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemNotFound));

		return modelMapper.map(contractItem, ContractItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractItemDTO.Info> list() {
		final List<ContractItem> slAll = contractItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractItemDTO.Info create(ContractItemDTO.Create request) {
		final ContractItem contractItem = modelMapper.map(request, ContractItem.class);

		return save(contractItem);
	}

	@Transactional
	@Override
	public ContractItemDTO.Info update(Long id, ContractItemDTO.Update request) {
		final Optional<ContractItem> slById = contractItemDAO.findById(id);
		final ContractItem contractItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemNotFound));

		ContractItem updating = new ContractItem();
		modelMapper.map(contractItem, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractItemDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractItemDTO.Delete request) {
		final List<ContractItem> contractItems = contractItemDAO.findAllById(request.getIds());

		contractItemDAO.deleteAll(contractItems);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractItemDAO, request, contractItem -> modelMapper.map(contractItem, ContractItemDTO.Info.class));
	}

	// ------------------------------

	private ContractItemDTO.Info save(ContractItem contractItem) {
		final ContractItem saved = contractItemDAO.saveAndFlush(contractItem);
		return modelMapper.map(saved, ContractItemDTO.Info.class);
	}
}
