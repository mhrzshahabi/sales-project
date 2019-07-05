package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.CurrencyRateDTO;

import java.util.List;

public interface ICurrencyRateService {

	CurrencyRateDTO.Info get(Long id);

	List<CurrencyRateDTO.Info> list();

	CurrencyRateDTO.Info create(CurrencyRateDTO.Create request);

	CurrencyRateDTO.Info update(Long id, CurrencyRateDTO.Update request);

	void delete(Long id);

	void delete(CurrencyRateDTO.Delete request);

	SearchDTO.SearchRs<CurrencyRateDTO.Info> search(SearchDTO.SearchRq request);
}
