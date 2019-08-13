package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CurrencyDTO;
import com.nicico.sales.iservice.ICurrencyService;
import com.nicico.sales.model.entities.base.Currency;
import com.nicico.sales.repository.CurrencyDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CurrencyService implements ICurrencyService {

	private final CurrencyDAO currencyDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public CurrencyDTO.Info get(Long id) {
		final Optional<Currency> slById = currencyDAO.findById(id);
		final Currency currency = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CurrencyNotFound));

		return modelMapper.map(currency, CurrencyDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<CurrencyDTO.Info> list() {
		final List<Currency> slAll = currencyDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<CurrencyDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public CurrencyDTO.Info create(CurrencyDTO.Create request) {
		final Currency currency = modelMapper.map(request, Currency.class);

		return save(currency);
	}

	@Transactional
	@Override
	public CurrencyDTO.Info update(Long id, CurrencyDTO.Update request) {
		final Optional<Currency> slById = currencyDAO.findById(id);
		final Currency currency = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CurrencyNotFound));

		Currency updating = new Currency();
		modelMapper.map(currency, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		currencyDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(CurrencyDTO.Delete request) {
		final List<Currency> currencys = currencyDAO.findAllById(request.getIds());

		currencyDAO.deleteAll(currencys);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<CurrencyDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(currencyDAO, request, currency -> modelMapper.map(currency, CurrencyDTO.Info.class));
	}

	// ------------------------------

	private CurrencyDTO.Info save(Currency currency) {
		final Currency saved = currencyDAO.saveAndFlush(currency);
		return modelMapper.map(saved, CurrencyDTO.Info.class);
	}
}
