package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.TozinDTO;

import java.util.List;

public interface ITozinService {

	TozinDTO.Info get(Long id);

	List<TozinDTO.Info> list();

	TozinDTO.Info create(TozinDTO.Create request);

	TozinDTO.Info update(Long id, TozinDTO.Update request);

	void delete(Long id);

	void delete(TozinDTO.Delete request);

	SearchDTO.SearchRs<TozinDTO.Info> search(SearchDTO.SearchRq request);

	List<Object[]> findTransport2Plants(String date, String plantId);

	String[] findPlants();

}
