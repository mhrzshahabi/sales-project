package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseCadDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;

public interface IWarehouseCadService {

	WarehouseCadDTO.Info get(Long id);

	List<WarehouseCadDTO.Info> list();

	WarehouseCadDTO.Info create(WarehouseCadDTO.Create request);

	WarehouseCadDTO.Info update(Long id, WarehouseCadDTO.Update request);

	void delete(Long id);

	void delete(WarehouseCadDTO.Delete request);

	TotalResponse<WarehouseCadDTO.Info> search(NICICOCriteria nicicoCriteria);

	SearchDTO.SearchRs<WarehouseCadDTO.Info> search(SearchDTO.SearchRq request);

}
