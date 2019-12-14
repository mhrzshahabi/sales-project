package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractCurrencyDTO;
import com.nicico.sales.iservice.IContractCurrencyService;
import com.nicico.sales.model.entities.base.ContractCurrency;
import com.nicico.sales.repository.ContractCurrencyDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractCurrencyService implements IContractCurrencyService {

	private final ContractCurrencyDAO contractCurrencyDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractCurrencyDTO.Info get(Long id) {
		final Optional<ContractCurrency> slById = contractCurrencyDAO.findById(id);
		final ContractCurrency contractCurrency = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractCurrencyNotFound));

		return modelMapper.map(contractCurrency, ContractCurrencyDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractCurrencyDTO.Info> list() {
		final List<ContractCurrency> slAll = contractCurrencyDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractCurrencyDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractCurrencyDTO.Info create(ContractCurrencyDTO.Create request) {
		final ContractCurrency contractCurrency = modelMapper.map(request, ContractCurrency.class);

		return save(contractCurrency);
	}

	@Transactional
	@Override
	public ContractCurrencyDTO.Info update(Long id, ContractCurrencyDTO.Update request) {
		final Optional<ContractCurrency> slById = contractCurrencyDAO.findById(id);
		final ContractCurrency contractCurrency = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractCurrencyNotFound));

		ContractCurrency updating = new ContractCurrency();
		modelMapper.map(contractCurrency, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractCurrencyDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractCurrencyDTO.Delete request) {
		final List<ContractCurrency> contractCurrencys = contractCurrencyDAO.findAllById(request.getIds());

		contractCurrencyDAO.deleteAll(contractCurrencys);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractCurrencyDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractCurrencyDAO, request, contractCurrency -> modelMapper.map(contractCurrency, ContractCurrencyDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_BANK')")
	public TotalResponse<ContractCurrencyDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(contractCurrencyDAO, criteria, contractCurrency -> modelMapper.map(contractCurrency, ContractCurrencyDTO.Info.class));
	}

	// ------------------------------

	private ContractCurrencyDTO.Info save(ContractCurrency contractCurrency) {
		final ContractCurrency saved = contractCurrencyDAO.saveAndFlush(contractCurrency);
		return modelMapper.map(saved, ContractCurrencyDTO.Info.class);
	}
}
