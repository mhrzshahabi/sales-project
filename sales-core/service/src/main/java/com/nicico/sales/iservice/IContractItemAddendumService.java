package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractItemAddendumDTO;

import java.util.List;

public interface IContractItemAddendumService {

	ContractItemAddendumDTO.Info get(Long id);

	List<ContractItemAddendumDTO.Info> list();

	ContractItemAddendumDTO.Info create(ContractItemAddendumDTO.Create request);

	ContractItemAddendumDTO.Info update(Long id, ContractItemAddendumDTO.Update request);

	void delete(Long id);

	void delete(ContractItemAddendumDTO.Delete request);

	SearchDTO.SearchRs<ContractItemAddendumDTO.Info> search(SearchDTO.SearchRq request);
}
