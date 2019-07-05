package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.TozinSalesDTO;

import java.util.List;

public interface ITozinSalesService {

	TozinSalesDTO.Info get(Long id);

	List<TozinSalesDTO.Info> list();

	TozinSalesDTO.Info create(TozinSalesDTO.Create request);

	TozinSalesDTO.Info update(Long id, TozinSalesDTO.Update request);

	void delete(Long id);

	void delete(TozinSalesDTO.Delete request);

	SearchDTO.SearchRs<TozinSalesDTO.Info> search(SearchDTO.SearchRq request);
}
