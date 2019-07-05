package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractPenaltyDTO;

import java.util.List;

public interface IContractPenaltyService {

	ContractPenaltyDTO.Info get(Long id);

	List<ContractPenaltyDTO.Info> list();

	ContractPenaltyDTO.Info create(ContractPenaltyDTO.Create request);

	ContractPenaltyDTO.Info update(Long id, ContractPenaltyDTO.Update request);

	void delete(Long id);

	void delete(ContractPenaltyDTO.Delete request);

	SearchDTO.SearchRs<ContractPenaltyDTO.Info> search(SearchDTO.SearchRq request);
}
