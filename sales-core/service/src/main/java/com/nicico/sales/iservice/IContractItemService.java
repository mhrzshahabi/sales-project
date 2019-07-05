package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractItemDTO;

import java.util.List;

public interface IContractItemService {

	ContractItemDTO.Info get(Long id);

	List<ContractItemDTO.Info> list();

	ContractItemDTO.Info create(ContractItemDTO.Create request);

	ContractItemDTO.Info update(Long id, ContractItemDTO.Update request);

	void delete(Long id);

	void delete(ContractItemDTO.Delete request);

	SearchDTO.SearchRs<ContractItemDTO.Info> search(SearchDTO.SearchRq request);
}
