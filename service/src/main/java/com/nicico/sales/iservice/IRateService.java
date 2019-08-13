package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.RateDTO;

import java.util.List;

public interface IRateService {

	RateDTO.Info get(Long id);

	List<RateDTO.Info> list();

	RateDTO.Info create(RateDTO.Create request);

	RateDTO.Info update(Long id, RateDTO.Update request);

	void delete(Long id);

	void delete(RateDTO.Delete request);

	SearchDTO.SearchRs<RateDTO.Info> search(SearchDTO.SearchRq request);
}
