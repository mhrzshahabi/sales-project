package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractPersonDTO;

import java.util.List;

public interface IContractPersonService {

	ContractPersonDTO.Info get(Long id);

	List<ContractPersonDTO.Info> list();

	ContractPersonDTO.Info create(ContractPersonDTO.Create request);

	ContractPersonDTO.Info update(Long id, ContractPersonDTO.Update request);

	void delete(Long id);

	void delete(ContractPersonDTO.Delete request);

	SearchDTO.SearchRs<ContractPersonDTO.Info> search(SearchDTO.SearchRq request);
}
