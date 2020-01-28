package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InspectionContractDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;

public interface IInspectionContractService {

	InspectionContractDTO.Info get(Long id);

	List<InspectionContractDTO.Info> list();

	InspectionContractDTO.Info create(InspectionContractDTO.Create request);

	InspectionContractDTO.Info update(Long id, InspectionContractDTO.Update request);

	void delete(Long id);

	void delete(InspectionContractDTO.Delete request);

	TotalResponse<InspectionContractDTO.Info> search(MultiValueMap<String, String> criteria);

	String getMaterial(Long id);

	List<String> email(Long id);
}
