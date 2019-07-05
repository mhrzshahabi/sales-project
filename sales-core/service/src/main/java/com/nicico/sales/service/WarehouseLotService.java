package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseLotDTO;
import com.nicico.sales.iservice.IWarehouseLotService;
import com.nicico.sales.model.entities.base.WarehouseLot;
import com.nicico.sales.repository.WarehouseLotDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseLotService implements IWarehouseLotService {

	private final WarehouseLotDAO warehouseLotDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public WarehouseLotDTO.Info get(Long id) {
		final Optional<WarehouseLot> slById = warehouseLotDAO.findById(id);
		final WarehouseLot warehouseLot = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseLotNotFound));

		return modelMapper.map(warehouseLot, WarehouseLotDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<WarehouseLotDTO.Info> list() {
		final List<WarehouseLot> slAll = warehouseLotDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<WarehouseLotDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public WarehouseLotDTO.Info create(WarehouseLotDTO.Create request) {
		final WarehouseLot warehouseLot = modelMapper.map(request, WarehouseLot.class);

		return save(warehouseLot);
	}

	@Transactional
	@Override
	public WarehouseLotDTO.Info update(Long id, WarehouseLotDTO.Update request) {
		final Optional<WarehouseLot> slById = warehouseLotDAO.findById(id);
		final WarehouseLot warehouseLot = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseLotNotFound));

		WarehouseLot updating = new WarehouseLot();
		modelMapper.map(warehouseLot, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		warehouseLotDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(WarehouseLotDTO.Delete request) {
		final List<WarehouseLot> warehouseLots = warehouseLotDAO.findAllById(request.getIds());

		warehouseLotDAO.deleteAll(warehouseLots);
	}

	public SearchDTO.SearchRs<WarehouseLotDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(warehouseLotDAO, request, warehouseLot -> modelMapper.map(warehouseLot, WarehouseLotDTO.Info.class));
	}

	// ------------------------------

	private WarehouseLotDTO.Info save(WarehouseLot warehouseLot) {
		final WarehouseLot saved = warehouseLotDAO.saveAndFlush(warehouseLot);
		return modelMapper.map(saved, WarehouseLotDTO.Info.class);
	}
}
