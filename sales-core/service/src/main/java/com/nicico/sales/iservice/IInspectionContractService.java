package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.InspectionContractDTO;

import java.util.List;

public interface IInspectionContractService {

	InspectionContractDTO.Info get(Long id);

	List<InspectionContractDTO.Info> list();

	InspectionContractDTO.Info create(InspectionContractDTO.Create request);

	InspectionContractDTO.Info update(Long id, InspectionContractDTO.Update request);

	void delete(Long id);

	void delete(InspectionContractDTO.Delete request);

	SearchDTO.SearchRs<InspectionContractDTO.Info> search(SearchDTO.SearchRq request);
}
