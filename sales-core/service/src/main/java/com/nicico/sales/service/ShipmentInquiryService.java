package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentInquiryDTO;
import com.nicico.sales.iservice.IShipmentInquiryService;
import com.nicico.sales.model.entities.base.ShipmentInquiry;
import com.nicico.sales.repository.ShipmentInquiryDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentInquiryService implements IShipmentInquiryService {

	private final ShipmentInquiryDAO shipmentInquiryDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentInquiryDTO.Info get(Long id) {
		final Optional<ShipmentInquiry> slById = shipmentInquiryDAO.findById(id);
		final ShipmentInquiry shipmentInquiry = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentInquiryNotFound));

		return modelMapper.map(shipmentInquiry, ShipmentInquiryDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentInquiryDTO.Info> list() {
		final List<ShipmentInquiry> slAll = shipmentInquiryDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentInquiryDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentInquiryDTO.Info create(ShipmentInquiryDTO.Create request) {
		final ShipmentInquiry shipmentInquiry = modelMapper.map(request, ShipmentInquiry.class);

		return save(shipmentInquiry);
	}

	@Transactional
	@Override
	public ShipmentInquiryDTO.Info update(Long id, ShipmentInquiryDTO.Update request) {
		final Optional<ShipmentInquiry> slById = shipmentInquiryDAO.findById(id);
		final ShipmentInquiry shipmentInquiry = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentInquiryNotFound));

		ShipmentInquiry updating = new ShipmentInquiry();
		modelMapper.map(shipmentInquiry, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentInquiryDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentInquiryDTO.Delete request) {
		final List<ShipmentInquiry> shipmentInquirys = shipmentInquiryDAO.findAllById(request.getIds());

		shipmentInquiryDAO.deleteAll(shipmentInquirys);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentInquiryDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentInquiryDAO, request, shipmentInquiry -> modelMapper.map(shipmentInquiry, ShipmentInquiryDTO.Info.class));
	}

	// ------------------------------

	private ShipmentInquiryDTO.Info save(ShipmentInquiry shipmentInquiry) {
		final ShipmentInquiry saved = shipmentInquiryDAO.saveAndFlush(shipmentInquiry);
		return modelMapper.map(saved, ShipmentInquiryDTO.Info.class);
	}
}
