package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;
import com.nicico.sales.iservice.IShipmentMoistureItemService;
import com.nicico.sales.model.entities.base.ShipmentMoistureItem;
import com.nicico.sales.repository.ShipmentMoistureItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentMoistureItemService implements IShipmentMoistureItemService {

	private final ShipmentMoistureItemDAO shipmentMoistureItemDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentMoistureItemDTO.Info get(Long id) {
		final Optional<ShipmentMoistureItem> slById = shipmentMoistureItemDAO.findById(id);
		final ShipmentMoistureItem shipmentMoistureItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureItemNotFound));

		return modelMapper.map(shipmentMoistureItem, ShipmentMoistureItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentMoistureItemDTO.Info> list() {
		final List<ShipmentMoistureItem> slAll = shipmentMoistureItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentMoistureItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentMoistureItemDTO.Info create(ShipmentMoistureItemDTO.Create request) {
		final ShipmentMoistureItem shipmentMoistureItem = modelMapper.map(request, ShipmentMoistureItem.class);

		return save(shipmentMoistureItem);
	}

	@Transactional
	@Override
	public ShipmentMoistureItemDTO.Info update(Long id, ShipmentMoistureItemDTO.Update request) {
		final Optional<ShipmentMoistureItem> slById = shipmentMoistureItemDAO.findById(id);
		final ShipmentMoistureItem shipmentMoistureItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentMoistureItemNotFound));

		ShipmentMoistureItem updating = new ShipmentMoistureItem();
		modelMapper.map(shipmentMoistureItem, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentMoistureItemDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentMoistureItemDTO.Delete request) {
		final List<ShipmentMoistureItem> shipmentMoistureItems = shipmentMoistureItemDAO.findAllById(request.getIds());

		shipmentMoistureItemDAO.deleteAll(shipmentMoistureItems);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentMoistureItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentMoistureItemDAO, request, shipmentMoistureItem -> modelMapper.map(shipmentMoistureItem, ShipmentMoistureItemDTO.Info.class));
	}

	// ------------------------------

	private ShipmentMoistureItemDTO.Info save(ShipmentMoistureItem shipmentMoistureItem) {
		final ShipmentMoistureItem saved = shipmentMoistureItemDAO.saveAndFlush(shipmentMoistureItem);
		return modelMapper.map(saved, ShipmentMoistureItemDTO.Info.class);
	}
}
