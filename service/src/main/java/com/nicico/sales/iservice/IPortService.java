package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PortDTO;

import java.util.List;

public interface IPortService {

	PortDTO.Info get(Long id);

	List<PortDTO.Info> list();

	PortDTO.Info create(PortDTO.Create request);

	PortDTO.Info update(Long id, PortDTO.Update request);

	void delete(Long id);

	void delete(PortDTO.Delete request);

	SearchDTO.SearchRs<PortDTO.Info> search(SearchDTO.SearchRq request);
}