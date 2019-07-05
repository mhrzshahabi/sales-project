package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.TozinSalesDTO;
import com.nicico.sales.iservice.ITozinSalesService;
import com.nicico.sales.model.entities.base.TozinSales;
import com.nicico.sales.repository.TozinSalesDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class TozinSalesService implements ITozinSalesService {

	private final TozinSalesDAO tozinSalesDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public TozinSalesDTO.Info get(Long id) {
		final Optional<TozinSales> slById = tozinSalesDAO.findById(id);
		final TozinSales tozinSales = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinSalesNotFound));

		return modelMapper.map(tozinSales, TozinSalesDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<TozinSalesDTO.Info> list() {
		final List<TozinSales> slAll = tozinSalesDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<TozinSalesDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public TozinSalesDTO.Info create(TozinSalesDTO.Create request) {
		final TozinSales tozinSales = modelMapper.map(request, TozinSales.class);

		return save(tozinSales);
	}

	@Transactional
	@Override
	public TozinSalesDTO.Info update(Long id, TozinSalesDTO.Update request) {
		final Optional<TozinSales> slById = tozinSalesDAO.findById(id);
		final TozinSales tozinSales = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinSalesNotFound));

		TozinSales updating = new TozinSales();
		modelMapper.map(tozinSales, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		tozinSalesDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(TozinSalesDTO.Delete request) {
		final List<TozinSales> tozinSaless = tozinSalesDAO.findAllById(request.getIds());

		tozinSalesDAO.deleteAll(tozinSaless);
	}

	public SearchDTO.SearchRs<TozinSalesDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(tozinSalesDAO, request, tozinSales -> modelMapper.map(tozinSales, TozinSalesDTO.Info.class));
	}

	// ------------------------------

	private TozinSalesDTO.Info save(TozinSales tozinSales) {
		final TozinSales saved = tozinSalesDAO.saveAndFlush(tozinSales);
		return modelMapper.map(saved, TozinSalesDTO.Info.class);
	}
}
