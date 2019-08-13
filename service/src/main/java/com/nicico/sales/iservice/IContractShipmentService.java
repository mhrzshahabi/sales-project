package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractShipmentDTO;

import java.util.List;

public interface IContractShipmentService {

	ContractShipmentDTO.Info get(Long id);

	List<ContractShipmentDTO.Info> list();

	ContractShipmentDTO.Info create(ContractShipmentDTO.Create request);

	ContractShipmentDTO.Info update(Long id, ContractShipmentDTO.Update request);

	void delete(Long id);

	void delete(ContractShipmentDTO.Delete request);

	SearchDTO.SearchRs<ContractShipmentDTO.Info> search(SearchDTO.SearchRq request);
}
