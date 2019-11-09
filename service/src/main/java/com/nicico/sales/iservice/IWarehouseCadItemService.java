package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseCadItemDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;

public interface IWarehouseCadItemService {

	WarehouseCadItemDTO.Info get(Long id);

	List<WarehouseCadItemDTO.Info> list();

	WarehouseCadItemDTO.Info create(WarehouseCadItemDTO.Create request);

	WarehouseCadItemDTO.Info update(Long id, WarehouseCadItemDTO.Update request);

	void delete(Long id);

	void delete(WarehouseCadItemDTO.Delete request);

	TotalResponse<WarehouseCadItemDTO.Info> search(MultiValueMap<String, String> criteria);

	SearchDTO.SearchRs<WarehouseCadItemDTO.Info> search(SearchDTO.SearchRq request);
}
