package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.iservice.IContractShipmentService;
import com.nicico.sales.model.entities.base.ContractShipment;
import com.nicico.sales.repository.ContractShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractShipmentService implements IContractShipmentService {

	private final ContractShipmentDAO contractShipmentDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractShipmentDTO.Info get(Long id) {
		final Optional<ContractShipment> slById = contractShipmentDAO.findById(id);
		final ContractShipment contractShipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractShipmentNotFound));

		return modelMapper.map(contractShipment, ContractShipmentDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractShipmentDTO.Info> list() {
		final List<ContractShipment> slAll = contractShipmentDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractShipmentDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractShipmentDTO.Info create(ContractShipmentDTO.Create request) {
		final ContractShipment contractShipment = modelMapper.map(request, ContractShipment.class);

		return save(contractShipment);
	}

	@Transactional
	@Override
	public ContractShipmentDTO.Info update(Long id, ContractShipmentDTO.Update request) {
		final Optional<ContractShipment> slById = contractShipmentDAO.findById(id);
		final ContractShipment contractShipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractShipmentNotFound));

		ContractShipment updating = new ContractShipment();
		modelMapper.map(contractShipment, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractShipmentDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractShipmentDTO.Delete request) {
		final List<ContractShipment> contractShipments = contractShipmentDAO.findAllById(request.getIds());

		contractShipmentDAO.deleteAll(contractShipments);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractShipmentDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractShipmentDAO, request, contractShipment -> modelMapper.map(contractShipment, ContractShipmentDTO.Info.class));
	}

	// ------------------------------

	private ContractShipmentDTO.Info save(ContractShipment contractShipment) {
		final ContractShipment saved = contractShipmentDAO.saveAndFlush(contractShipment);
		return modelMapper.map(saved, ContractShipmentDTO.Info.class);
	}
}
