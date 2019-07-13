package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentAssayHeaderDTO;
import com.nicico.sales.iservice.IShipmentAssayHeaderService;
import com.nicico.sales.model.entities.base.ShipmentAssayHeader;
import com.nicico.sales.repository.ShipmentAssayHeaderDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentAssayHeaderService implements IShipmentAssayHeaderService {

	private final ShipmentAssayHeaderDAO shipmentAssayHeaderDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentAssayHeaderDTO.Info get(Long id) {
		final Optional<ShipmentAssayHeader> slById = shipmentAssayHeaderDAO.findById(id);
		final ShipmentAssayHeader shipmentAssayHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayHeaderNotFound));

		return modelMapper.map(shipmentAssayHeader, ShipmentAssayHeaderDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentAssayHeaderDTO.Info> list() {
		final List<ShipmentAssayHeader> slAll = shipmentAssayHeaderDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentAssayHeaderDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentAssayHeaderDTO.Info create(ShipmentAssayHeaderDTO.Create request) {
		final ShipmentAssayHeader shipmentAssayHeader = modelMapper.map(request, ShipmentAssayHeader.class);

		return save(shipmentAssayHeader);
	}

	@Transactional
	@Override
	public ShipmentAssayHeaderDTO.Info update(Long id, ShipmentAssayHeaderDTO.Update request) {
		final Optional<ShipmentAssayHeader> slById = shipmentAssayHeaderDAO.findById(id);
		final ShipmentAssayHeader shipmentAssayHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayHeaderNotFound));

		ShipmentAssayHeader updating = new ShipmentAssayHeader();
		modelMapper.map(shipmentAssayHeader, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentAssayHeaderDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentAssayHeaderDTO.Delete request) {
		final List<ShipmentAssayHeader> shipmentAssayHeaders = shipmentAssayHeaderDAO.findAllById(request.getIds());

		shipmentAssayHeaderDAO.deleteAll(shipmentAssayHeaders);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentAssayHeaderDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentAssayHeaderDAO, request, shipmentAssayHeader -> modelMapper.map(shipmentAssayHeader, ShipmentAssayHeaderDTO.Info.class));
	}

	// ------------------------------

	private ShipmentAssayHeaderDTO.Info save(ShipmentAssayHeader shipmentAssayHeader) {
		final ShipmentAssayHeader saved = shipmentAssayHeaderDAO.saveAndFlush(shipmentAssayHeader);
		return modelMapper.map(saved, ShipmentAssayHeaderDTO.Info.class);
	}
}
