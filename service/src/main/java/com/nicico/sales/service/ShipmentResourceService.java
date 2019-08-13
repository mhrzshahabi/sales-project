package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentResourceDTO;
import com.nicico.sales.iservice.IShipmentResourceService;
import com.nicico.sales.model.entities.base.ShipmentResource;
import com.nicico.sales.repository.ShipmentResourceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentResourceService implements IShipmentResourceService {

	private final ShipmentResourceDAO shipmentResourceDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentResourceDTO.Info get(Long id) {
		final Optional<ShipmentResource> slById = shipmentResourceDAO.findById(id);
		final ShipmentResource shipmentResource = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentResourceNotFound));

		return modelMapper.map(shipmentResource, ShipmentResourceDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentResourceDTO.Info> list() {
		final List<ShipmentResource> slAll = shipmentResourceDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentResourceDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentResourceDTO.Info create(ShipmentResourceDTO.Create request) {
		final ShipmentResource shipmentResource = modelMapper.map(request, ShipmentResource.class);

		return save(shipmentResource);
	}

	@Transactional
	@Override
	public ShipmentResourceDTO.Info update(Long id, ShipmentResourceDTO.Update request) {
		final Optional<ShipmentResource> slById = shipmentResourceDAO.findById(id);
		final ShipmentResource shipmentResource = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentResourceNotFound));

		ShipmentResource updating = new ShipmentResource();
		modelMapper.map(shipmentResource, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentResourceDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentResourceDTO.Delete request) {
		final List<ShipmentResource> shipmentResources = shipmentResourceDAO.findAllById(request.getIds());

		shipmentResourceDAO.deleteAll(shipmentResources);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentResourceDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentResourceDAO, request, shipmentResource -> modelMapper.map(shipmentResource, ShipmentResourceDTO.Info.class));
	}

	// ------------------------------

	private ShipmentResourceDTO.Info save(ShipmentResource shipmentResource) {
		final ShipmentResource saved = shipmentResourceDAO.saveAndFlush(shipmentResource);
		return modelMapper.map(saved, ShipmentResourceDTO.Info.class);
	}
}
