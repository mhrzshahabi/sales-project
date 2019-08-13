package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.BolHeaderDTO;

import java.util.List;

public interface IBolHeaderService {

	BolHeaderDTO.Info get(Long id);

	List<BolHeaderDTO.Info> list();

	BolHeaderDTO.Info create(BolHeaderDTO.Create request);

	BolHeaderDTO.Info update(Long id, BolHeaderDTO.Update request);

	void delete(Long id);

	void delete(BolHeaderDTO.Delete request);

	SearchDTO.SearchRs<BolHeaderDTO.Info> search(SearchDTO.SearchRq request);
}
