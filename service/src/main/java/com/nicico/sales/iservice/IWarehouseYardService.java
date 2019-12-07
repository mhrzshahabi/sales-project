package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseYardDTO;

import java.util.List;

public interface IWarehouseYardService {

	WarehouseYardDTO.Info get(Long id);

	List<WarehouseYardDTO.Info> list();

	WarehouseYardDTO.Info create(WarehouseYardDTO.Create request);

	WarehouseYardDTO.Info update(Long id, WarehouseYardDTO.Update request);

	void delete(Long id);

	void delete(WarehouseYardDTO.Delete request);

	TotalResponse<WarehouseYardDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<WarehouseYardDTO.Info> search(SearchDTO.SearchRq request);
}
