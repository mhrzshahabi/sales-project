package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractItemShipmentDTO;
import com.nicico.sales.iservice.IContractItemShipmentService;
import com.nicico.sales.model.entities.base.ContractItemShipment;
import com.nicico.sales.repository.ContractItemShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractItemShipmentService implements IContractItemShipmentService {

	private final ContractItemShipmentDAO contractItemShipmentDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractItemShipmentDTO.Info get(Long id) {
		final Optional<ContractItemShipment> slById = contractItemShipmentDAO.findById(id);
		final ContractItemShipment contractItemShipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemShipmentNotFound));

		return modelMapper.map(contractItemShipment, ContractItemShipmentDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractItemShipmentDTO.Info> list() {
		final List<ContractItemShipment> slAll = contractItemShipmentDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractItemShipmentDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractItemShipmentDTO.Info create(ContractItemShipmentDTO.Create request) {
		final ContractItemShipment contractItemShipment = modelMapper.map(request, ContractItemShipment.class);

		return save(contractItemShipment);
	}

	@Transactional
	@Override
	public ContractItemShipmentDTO.Info update(Long id, ContractItemShipmentDTO.Update request) {
		final Optional<ContractItemShipment> slById = contractItemShipmentDAO.findById(id);
		final ContractItemShipment contractItemShipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractItemShipmentNotFound));

		ContractItemShipment updating = new ContractItemShipment();
		modelMapper.map(contractItemShipment, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractItemShipmentDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractItemShipmentDTO.Delete request) {
		final List<ContractItemShipment> contractItemShipments = contractItemShipmentDAO.findAllById(request.getIds());

		contractItemShipmentDAO.deleteAll(contractItemShipments);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractItemShipmentDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractItemShipmentDAO, request, contractItemShipment -> modelMapper.map(contractItemShipment, ContractItemShipmentDTO.Info.class));
	}

	// ------------------------------

	private ContractItemShipmentDTO.Info save(ContractItemShipment contractItemShipment) {
		final ContractItemShipment saved = contractItemShipmentDAO.saveAndFlush(contractItemShipment);
		return modelMapper.map(saved, ContractItemShipmentDTO.Info.class);
	}
}
