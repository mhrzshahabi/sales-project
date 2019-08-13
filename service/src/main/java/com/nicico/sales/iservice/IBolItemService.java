package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.BolItemDTO;

import java.util.List;

public interface IBolItemService {

	BolItemDTO.Info get(Long id);

	List<BolItemDTO.Info> list();

	BolItemDTO.Info create(BolItemDTO.Create request);

	BolItemDTO.Info update(Long id, BolItemDTO.Update request);

	void delete(Long id);

	void delete(BolItemDTO.Delete request);

	SearchDTO.SearchRs<BolItemDTO.Info> search(SearchDTO.SearchRq request);
}
