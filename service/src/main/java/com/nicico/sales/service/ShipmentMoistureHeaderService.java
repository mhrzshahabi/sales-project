package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentMoistureHeaderDTO;
import com.nicico.sales.iservice.IShipmentMoistureHeaderService;
import com.nicico.sales.model.entities.base.ShipmentMoistureHeader;
import com.nicico.sales.repository.ShipmentMoistureHeaderDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentMoistureHeaderService implements IShipmentMoistureHeaderService {

	private final ShipmentMoistureHeaderDAO shipmentMoistureHeaderDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentMoistureHeaderDTO.Info get(Long id) {
		final Optional<ShipmentMoistureHeader> slById = shipmentMoistureHeaderDAO.findById(id);
		final ShipmentMoistureHeader shipmentMoistureHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureHeaderNotFound));

		return modelMapper.map(shipmentMoistureHeader, ShipmentMoistureHeaderDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentMoistureHeaderDTO.Info> list() {
		final List<ShipmentMoistureHeader> slAll = shipmentMoistureHeaderDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentMoistureHeaderDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentMoistureHeaderDTO.Info create(ShipmentMoistureHeaderDTO.Create request) {
		final ShipmentMoistureHeader shipmentMoistureHeader = modelMapper.map(request, ShipmentMoistureHeader.class);

		return save(shipmentMoistureHeader);
	}

	@Transactional
	@Override
	public ShipmentMoistureHeaderDTO.Info update(Long id, ShipmentMoistureHeaderDTO.Update request) {
		final Optional<ShipmentMoistureHeader> slById = shipmentMoistureHeaderDAO.findById(id);
		final ShipmentMoistureHeader shipmentMoistureHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureHeaderNotFound));

		ShipmentMoistureHeader updating = new ShipmentMoistureHeader();
		modelMapper.map(shipmentMoistureHeader, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentMoistureHeaderDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentMoistureHeaderDTO.Delete request) {
		final List<ShipmentMoistureHeader> shipmentMoistureHeaders = shipmentMoistureHeaderDAO.findAllById(request.getIds());

		shipmentMoistureHeaderDAO.deleteAll(shipmentMoistureHeaders);
	}

	@Transactional(readOnly = true)
	@Override
	public TotalResponse<ShipmentMoistureHeaderDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(shipmentMoistureHeaderDAO, criteria, instruction -> modelMapper.map(instruction, ShipmentMoistureHeaderDTO.Info.class));
	}



	private ShipmentMoistureHeaderDTO.Info save(ShipmentMoistureHeader shipmentMoistureHeader) {
		final ShipmentMoistureHeader saved = shipmentMoistureHeaderDAO.saveAndFlush(shipmentMoistureHeader);
		return modelMapper.map(saved, ShipmentMoistureHeaderDTO.Info.class);
	}
}
