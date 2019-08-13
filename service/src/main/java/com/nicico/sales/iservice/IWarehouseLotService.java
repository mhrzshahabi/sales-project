package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseLotDTO;

import java.util.List;

public interface IWarehouseLotService {

	WarehouseLotDTO.Info get(Long id);

	List<WarehouseLotDTO.Info> list();

	WarehouseLotDTO.Info create(WarehouseLotDTO.Create request);

	WarehouseLotDTO.Info update(Long id, WarehouseLotDTO.Update request);

	void delete(Long id);

	void delete(WarehouseLotDTO.Delete request);

	SearchDTO.SearchRs<WarehouseLotDTO.Info> search(SearchDTO.SearchRq request);
}
