package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.DailyWarehouseDTO;

import java.util.List;

public interface IDailyWarehouseService {

	DailyWarehouseDTO.Info get(Long id);

	List<DailyWarehouseDTO.Info> list();

	DailyWarehouseDTO.Info create(DailyWarehouseDTO.Create request);

	DailyWarehouseDTO.Info update(Long id, DailyWarehouseDTO.Update request);

	void delete(Long id);

	void delete(DailyWarehouseDTO.Delete request);

	SearchDTO.SearchRs<DailyWarehouseDTO.Info> search(SearchDTO.SearchRq request);
}
