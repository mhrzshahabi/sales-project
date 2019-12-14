package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CurrencyDTO;

import java.util.List;

public interface ICurrencyService {

	CurrencyDTO.Info get(Long id);

	List<CurrencyDTO.Info> list();

	CurrencyDTO.Info create(CurrencyDTO.Create request);

	CurrencyDTO.Info update(Long id, CurrencyDTO.Update request);

	void delete(Long id);

	void delete(CurrencyDTO.Delete request);

	SearchDTO.SearchRs<CurrencyDTO.Info> search(SearchDTO.SearchRq request);

	TotalResponse<CurrencyDTO.Info> search(NICICOCriteria criteria);
}
