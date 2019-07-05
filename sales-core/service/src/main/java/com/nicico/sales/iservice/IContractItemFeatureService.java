package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractItemFeatureDTO;

import java.util.List;

public interface IContractItemFeatureService {

	ContractItemFeatureDTO.Info get(Long id);

	List<ContractItemFeatureDTO.Info> list();

	ContractItemFeatureDTO.Info create(ContractItemFeatureDTO.Create request);

	ContractItemFeatureDTO.Info update(Long id, ContractItemFeatureDTO.Update request);

	void delete(Long id);

	void delete(ContractItemFeatureDTO.Delete request);

	SearchDTO.SearchRs<ContractItemFeatureDTO.Info> search(SearchDTO.SearchRq request);
}
