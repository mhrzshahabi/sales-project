package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.DailyWarehouseDTO;
import com.nicico.sales.iservice.IDailyWarehouseService;
import com.nicico.sales.model.entities.base.DailyWarehouse;
import com.nicico.sales.repository.DailyWarehouseDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class DailyWarehouseService implements IDailyWarehouseService {

	private final DailyWarehouseDAO dailyWarehouseDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public DailyWarehouseDTO.Info get(Long id) {
		final Optional<DailyWarehouse> slById = dailyWarehouseDAO.findById(id);
		final DailyWarehouse dailyWarehouse = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyWarehouseNotFound));

		return modelMapper.map(dailyWarehouse, DailyWarehouseDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<DailyWarehouseDTO.Info> list() {
		final List<DailyWarehouse> slAll = dailyWarehouseDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<DailyWarehouseDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public DailyWarehouseDTO.Info create(DailyWarehouseDTO.Create request) {
		final DailyWarehouse dailyWarehouse = modelMapper.map(request, DailyWarehouse.class);

		return save(dailyWarehouse);
	}

	@Transactional
	@Override
	public DailyWarehouseDTO.Info update(Long id, DailyWarehouseDTO.Update request) {
		final Optional<DailyWarehouse> slById = dailyWarehouseDAO.findById(id);
		final DailyWarehouse dailyWarehouse = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyWarehouseNotFound));

		DailyWarehouse updating = new DailyWarehouse();
		modelMapper.map(dailyWarehouse, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		dailyWarehouseDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(DailyWarehouseDTO.Delete request) {
		final List<DailyWarehouse> dailyWarehouses = dailyWarehouseDAO.findAllById(request.getIds());

		dailyWarehouseDAO.deleteAll(dailyWarehouses);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<DailyWarehouseDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(dailyWarehouseDAO, request, dailyWarehouse -> modelMapper.map(dailyWarehouse, DailyWarehouseDTO.Info.class));
	}

	// ------------------------------

	private DailyWarehouseDTO.Info save(DailyWarehouse dailyWarehouse) {
		final DailyWarehouse saved = dailyWarehouseDAO.saveAndFlush(dailyWarehouse);
		return modelMapper.map(saved, DailyWarehouseDTO.Info.class);
	}
}
