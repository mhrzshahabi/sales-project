package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentContractDTO;
import com.nicico.sales.iservice.IShipmentContractService;
import com.nicico.sales.model.entities.base.ShipmentContract;
import com.nicico.sales.repository.ShipmentContractDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ShipmentContractService implements IShipmentContractService {

	private final ShipmentContractDAO shipmentContractDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ShipmentContractDTO.Info get(Long id) {
		final Optional<ShipmentContract> slById = shipmentContractDAO.findById(id);
		final ShipmentContract shipmentContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentContractNotFound));

		return modelMapper.map(shipmentContract, ShipmentContractDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ShipmentContractDTO.Info> list() {
		final List<ShipmentContract> slAll = shipmentContractDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ShipmentContractDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ShipmentContractDTO.Info create(ShipmentContractDTO.Create request) {
		final ShipmentContract shipmentContract = modelMapper.map(request, ShipmentContract.class);

		return save(shipmentContract);
	}

	@Transactional
	@Override
	public ShipmentContractDTO.Info update(Long id, ShipmentContractDTO.Update request) {
		final Optional<ShipmentContract> slById = shipmentContractDAO.findById(id);
		final ShipmentContract shipmentContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentContractNotFound));

		ShipmentContract updating = new ShipmentContract();
		modelMapper.map(shipmentContract, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		shipmentContractDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ShipmentContractDTO.Delete request) {
		final List<ShipmentContract> shipmentContracts = shipmentContractDAO.findAllById(request.getIds());

		shipmentContractDAO.deleteAll(shipmentContracts);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ShipmentContractDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(shipmentContractDAO, request, shipmentContract -> modelMapper.map(shipmentContract, ShipmentContractDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_BANK')")
	public TotalResponse<ShipmentContractDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(shipmentContractDAO, criteria, shipmentContract -> modelMapper.map(shipmentContract, ShipmentContractDTO.Info.class));
	}

	// ------------------------------

	private ShipmentContractDTO.Info save(ShipmentContract shipmentContract) {
		final ShipmentContract saved = shipmentContractDAO.saveAndFlush(shipmentContract);
		return modelMapper.map(saved, ShipmentContractDTO.Info.class);
	}
}
