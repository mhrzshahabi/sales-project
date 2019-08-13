package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.iservice.IBankService;
import com.nicico.sales.model.entities.base.Bank;
import com.nicico.sales.repository.BankDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class BankService implements IBankService {

	private final BankDAO bankDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public BankDTO.Info get(Long id) {
		final Optional<Bank> slById = bankDAO.findById(id);
		final Bank bank = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BankNotFound));

		return modelMapper.map(bank, BankDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<BankDTO.Info> list() {
		final List<Bank> slAll = bankDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<BankDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public BankDTO.Info create(BankDTO.Create request) {
		final Bank bank = modelMapper.map(request, Bank.class);

		return save(bank);
	}

	@Transactional
	@Override
	public BankDTO.Info update(Long id, BankDTO.Update request) {
		final Optional<Bank> slById = bankDAO.findById(id);
		final Bank bank = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BankNotFound));

		Bank updating = new Bank();
		modelMapper.map(bank, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		bankDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(BankDTO.Delete request) {
		final List<Bank> banks = bankDAO.findAllById(request.getIds());

		bankDAO.deleteAll(banks);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<BankDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(bankDAO, request, bank -> modelMapper.map(bank, BankDTO.Info.class));
	}

	// ------------------------------

	private BankDTO.Info save(Bank bank) {
		final Bank saved = bankDAO.saveAndFlush(bank);
		return modelMapper.map(saved, BankDTO.Info.class);
	}
}
