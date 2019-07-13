package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentAssayItemDTO;
import com.nicico.sales.iservice.IShipmentAssayItemService;
import com.nicico.sales.model.entities.base.ShipmentAssayItem;
import com.nicico.sales.repository.ShipmentAssayItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentAssayItemService implements IShipmentAssayItemService {

	private final ShipmentAssayItemDAO shipmentAssayItemDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentAssayItemDTO.Info get(Long id) {
		final Optional<ShipmentAssayItem> slById = shipmentAssayItemDAO.findById(id);
		final ShipmentAssayItem shipmentAssayItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayItemNotFound));

		return modelMapper.map(shipmentAssayItem, ShipmentAssayItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentAssayItemDTO.Info> list() {
		final List<ShipmentAssayItem> slAll = shipmentAssayItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentAssayItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentAssayItemDTO.Info create(ShipmentAssayItemDTO.Create request) {
		final ShipmentAssayItem shipmentAssayItem = modelMapper.map(request, ShipmentAssayItem.class);

		return save(shipmentAssayItem);
	}

	@Transactional
	@Override
	public ShipmentAssayItemDTO.Info update(Long id, ShipmentAssayItemDTO.Update request) {
		final Optional<ShipmentAssayItem> slById = shipmentAssayItemDAO.findById(id);
		final ShipmentAssayItem shipmentAssayItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentAssayItemNotFound));

		ShipmentAssayItem updating = new ShipmentAssayItem();
		modelMapper.map(shipmentAssayItem, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentAssayItemDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentAssayItemDTO.Delete request) {
		final List<ShipmentAssayItem> shipmentAssayItems = shipmentAssayItemDAO.findAllById(request.getIds());

		shipmentAssayItemDAO.deleteAll(shipmentAssayItems);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentAssayItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentAssayItemDAO, request, shipmentAssayItem -> modelMapper.map(shipmentAssayItem, ShipmentAssayItemDTO.Info.class));
	}

	// ------------------------------

	private ShipmentAssayItemDTO.Info save(ShipmentAssayItem shipmentAssayItem) {
		final ShipmentAssayItem saved = shipmentAssayItemDAO.saveAndFlush(shipmentAssayItem);
		return modelMapper.map(saved, ShipmentAssayItemDTO.Info.class);
	}
}
