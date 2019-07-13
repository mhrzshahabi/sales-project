package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentPriceDTO;
import com.nicico.sales.iservice.IShipmentPriceService;
import com.nicico.sales.model.entities.base.ShipmentPrice;
import com.nicico.sales.repository.ShipmentPriceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentPriceService implements IShipmentPriceService {

	private final ShipmentPriceDAO shipmentPriceDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentPriceDTO.Info get(Long id) {
		final Optional<ShipmentPrice> slById = shipmentPriceDAO.findById(id);
		final ShipmentPrice shipmentPrice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentPriceNotFound));

		return modelMapper.map(shipmentPrice, ShipmentPriceDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentPriceDTO.Info> list() {
		final List<ShipmentPrice> slAll = shipmentPriceDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentPriceDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentPriceDTO.Info create(ShipmentPriceDTO.Create request) {
		final ShipmentPrice shipmentPrice = modelMapper.map(request, ShipmentPrice.class);

		return save(shipmentPrice);
	}

	@Transactional
	@Override
	public ShipmentPriceDTO.Info update(Long id, ShipmentPriceDTO.Update request) {
		final Optional<ShipmentPrice> slById = shipmentPriceDAO.findById(id);
		final ShipmentPrice shipmentPrice = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentPriceNotFound));

		ShipmentPrice updating = new ShipmentPrice();
		modelMapper.map(shipmentPrice, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentPriceDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentPriceDTO.Delete request) {
		final List<ShipmentPrice> shipmentPrices = shipmentPriceDAO.findAllById(request.getIds());

		shipmentPriceDAO.deleteAll(shipmentPrices);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentPriceDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentPriceDAO, request, shipmentPrice -> modelMapper.map(shipmentPrice, ShipmentPriceDTO.Info.class));
	}

	// ------------------------------

	private ShipmentPriceDTO.Info save(ShipmentPrice shipmentPrice) {
		final ShipmentPrice saved = shipmentPriceDAO.saveAndFlush(shipmentPrice);
		return modelMapper.map(saved, ShipmentPriceDTO.Info.class);
	}
}
