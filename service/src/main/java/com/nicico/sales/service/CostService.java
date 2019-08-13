package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CostDTO;
import com.nicico.sales.iservice.ICostService;
import com.nicico.sales.model.entities.base.Cost;
import com.nicico.sales.repository.CostDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CostService implements ICostService {

	private final CostDAO costDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public CostDTO.Info get(Long id) {
		final Optional<Cost> slById = costDAO.findById(id);
		final Cost cost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CostNotFound));

		return modelMapper.map(cost, CostDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<CostDTO.Info> list() {
		final List<Cost> slAll = costDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<CostDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public CostDTO.Info create(CostDTO.Create request) {
		final Cost cost = modelMapper.map(request, Cost.class);

		return save(cost);
	}

	@Transactional
	@Override
	public CostDTO.Info update(Long id, CostDTO.Update request) {
		final Optional<Cost> slById = costDAO.findById(id);
		final Cost cost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CostNotFound));

		Cost updating = new Cost();
		modelMapper.map(cost, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		costDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(CostDTO.Delete request) {
		final List<Cost> costs = costDAO.findAllById(request.getIds());

		costDAO.deleteAll(costs);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<CostDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(costDAO, request, cost -> modelMapper.map(cost, CostDTO.Info.class));
	}

	// ------------------------------

	private CostDTO.Info save(Cost cost) {
		final Cost saved = costDAO.saveAndFlush(cost);
		return modelMapper.map(saved, CostDTO.Info.class);
	}
}
