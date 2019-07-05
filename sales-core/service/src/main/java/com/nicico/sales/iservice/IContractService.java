package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractDTO;

import java.util.List;

public interface IContractService {

	ContractDTO.Info get(Long id);

	List<ContractDTO.Info> list();

	ContractDTO.Info create(ContractDTO.Create request);

	ContractDTO.Info update(Long id, ContractDTO.Update request);

	void delete(Long id);

	void delete(ContractDTO.Delete request);

	SearchDTO.SearchRs<ContractDTO.Info> search(SearchDTO.SearchRq request);
}
