package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractItemShipmentDTO;

import java.util.List;

public interface IContractItemShipmentService {

	ContractItemShipmentDTO.Info get(Long id);

	List<ContractItemShipmentDTO.Info> list();

	ContractItemShipmentDTO.Info create(ContractItemShipmentDTO.Create request);

	ContractItemShipmentDTO.Info update(Long id, ContractItemShipmentDTO.Update request);

	void delete(Long id);

	void delete(ContractItemShipmentDTO.Delete request);

	SearchDTO.SearchRs<ContractItemShipmentDTO.Info> search(SearchDTO.SearchRq request);
}
