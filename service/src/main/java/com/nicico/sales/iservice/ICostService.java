package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CostDTO;

import java.util.List;

public interface ICostService {

	CostDTO.Info get(Long id);

	List<CostDTO.Info> list();

	CostDTO.Info create(CostDTO.Create request);

	CostDTO.Info update(Long id, CostDTO.Update request);

	void delete(Long id);

	void delete(CostDTO.Delete request);

	TotalResponse<CostDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<CostDTO.Info> search(SearchDTO.SearchRq request);
}
