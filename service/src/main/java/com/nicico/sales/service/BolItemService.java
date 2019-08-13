package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.BolItemDTO;
import com.nicico.sales.iservice.IBolItemService;
import com.nicico.sales.model.entities.base.BolItem;
import com.nicico.sales.repository.BolItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class BolItemService implements IBolItemService {

	private final BolItemDAO bolItemDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public BolItemDTO.Info get(Long id) {
		final Optional<BolItem> slById = bolItemDAO.findById(id);
		final BolItem bolItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BolItemNotFound));

		return modelMapper.map(bolItem, BolItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<BolItemDTO.Info> list() {
		final List<BolItem> slAll = bolItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<BolItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public BolItemDTO.Info create(BolItemDTO.Create request) {
		final BolItem bolItem = modelMapper.map(request, BolItem.class);

		return save(bolItem);
	}

	@Transactional
	@Override
	public BolItemDTO.Info update(Long id, BolItemDTO.Update request) {
		final Optional<BolItem> slById = bolItemDAO.findById(id);
		final BolItem bolItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BolItemNotFound));

		BolItem updating = new BolItem();
		modelMapper.map(bolItem, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		bolItemDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(BolItemDTO.Delete request) {
		final List<BolItem> bolItems = bolItemDAO.findAllById(request.getIds());

		bolItemDAO.deleteAll(bolItems);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<BolItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(bolItemDAO, request, bolItem -> modelMapper.map(bolItem, BolItemDTO.Info.class));
	}

	// ------------------------------

	private BolItemDTO.Info save(BolItem bolItem) {
		final BolItem saved = bolItemDAO.saveAndFlush(bolItem);
		return modelMapper.map(saved, BolItemDTO.Info.class);
	}
}
