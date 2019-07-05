package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentHeaderDTO;
import com.nicico.sales.iservice.IShipmentHeaderService;
import com.nicico.sales.model.entities.base.ShipmentHeader;
import com.nicico.sales.repository.ShipmentHeaderDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentHeaderService implements IShipmentHeaderService {

	private final ShipmentHeaderDAO shipmentHeaderDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentHeaderDTO.Info get(Long id) {
		final Optional<ShipmentHeader> slById = shipmentHeaderDAO.findById(id);
		final ShipmentHeader shipmentHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentHeaderNotFound));

		return modelMapper.map(shipmentHeader, ShipmentHeaderDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentHeaderDTO.Info> list() {
		final List<ShipmentHeader> slAll = shipmentHeaderDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentHeaderDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentHeaderDTO.Info create(ShipmentHeaderDTO.Create request) {
		final ShipmentHeader shipmentHeader = modelMapper.map(request, ShipmentHeader.class);

		return save(shipmentHeader);
	}

	@Transactional
	@Override
	public ShipmentHeaderDTO.Info update(Long id, ShipmentHeaderDTO.Update request) {
		final Optional<ShipmentHeader> slById = shipmentHeaderDAO.findById(id);
		final ShipmentHeader shipmentHeader = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentHeaderNotFound));

		ShipmentHeader updating = new ShipmentHeader();
		modelMapper.map(shipmentHeader, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentHeaderDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentHeaderDTO.Delete request) {
		final List<ShipmentHeader> shipmentHeaders = shipmentHeaderDAO.findAllById(request.getIds());

		shipmentHeaderDAO.deleteAll(shipmentHeaders);
	}

	public SearchDTO.SearchRs<ShipmentHeaderDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentHeaderDAO, request, shipmentHeader -> modelMapper.map(shipmentHeader, ShipmentHeaderDTO.Info.class));
	}

	// ------------------------------

	private ShipmentHeaderDTO.Info save(ShipmentHeader shipmentHeader) {
		final ShipmentHeader saved = shipmentHeaderDAO.saveAndFlush(shipmentHeader);
		return modelMapper.map(saved, ShipmentHeaderDTO.Info.class);
	}
}
