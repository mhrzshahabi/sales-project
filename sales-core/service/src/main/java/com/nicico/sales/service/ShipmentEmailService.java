package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentEmailDTO;
import com.nicico.sales.iservice.IShipmentEmailService;
import com.nicico.sales.model.entities.base.ShipmentEmail;
import com.nicico.sales.repository.ShipmentEmailDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentEmailService implements IShipmentEmailService {

	private final ShipmentEmailDAO shipmentEmailDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentEmailDTO.Info get(Long id) {
		final Optional<ShipmentEmail> slById = shipmentEmailDAO.findById(id);
		final ShipmentEmail shipmentEmail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentEmailNotFound));

		return modelMapper.map(shipmentEmail, ShipmentEmailDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentEmailDTO.Info> list() {
		final List<ShipmentEmail> slAll = shipmentEmailDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentEmailDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentEmailDTO.Info create(ShipmentEmailDTO.Create request) {
		final ShipmentEmail shipmentEmail = modelMapper.map(request, ShipmentEmail.class);

		return save(shipmentEmail);
	}

	@Transactional
	@Override
	public ShipmentEmailDTO.Info update(Long id, ShipmentEmailDTO.Update request) {
		final Optional<ShipmentEmail> slById = shipmentEmailDAO.findById(id);
		final ShipmentEmail shipmentEmail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentEmailNotFound));

		ShipmentEmail updating = new ShipmentEmail();
		modelMapper.map(shipmentEmail, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentEmailDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentEmailDTO.Delete request) {
		final List<ShipmentEmail> shipmentEmails = shipmentEmailDAO.findAllById(request.getIds());

		shipmentEmailDAO.deleteAll(shipmentEmails);
	}

	public SearchDTO.SearchRs<ShipmentEmailDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentEmailDAO, request, shipmentEmail -> modelMapper.map(shipmentEmail, ShipmentEmailDTO.Info.class));
	}

	// ------------------------------

	private ShipmentEmailDTO.Info save(ShipmentEmail shipmentEmail) {
		final ShipmentEmail saved = shipmentEmailDAO.saveAndFlush(shipmentEmail);
		return modelMapper.map(saved, ShipmentEmailDTO.Info.class);
	}
}
