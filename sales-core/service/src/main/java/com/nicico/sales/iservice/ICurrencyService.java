package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
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
}
