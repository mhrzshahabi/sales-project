package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractAddendumDTO;

import java.util.List;

public interface IContractAddendumService {

	ContractAddendumDTO.Info get(Long id);

	List<ContractAddendumDTO.Info> list();

	ContractAddendumDTO.Info create(ContractAddendumDTO.Create request);

	ContractAddendumDTO.Info update(Long id, ContractAddendumDTO.Update request);

	void delete(Long id);

	void delete(ContractAddendumDTO.Delete request);

	SearchDTO.SearchRs<ContractAddendumDTO.Info> search(SearchDTO.SearchRq request);
}
