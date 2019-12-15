package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.dto.PortDTO;

import java.util.List;

public interface IPortService {

	PortDTO.Info get(Long id);

	List<PortDTO.Info> list();

	PortDTO.Info create(PortDTO.Create request);

	PortDTO.Info update(Long id, PortDTO.Update request);

	void delete(Long id);

	void delete(PortDTO.Delete request);

	TotalResponse<PortDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<PortDTO.Info> search(SearchDTO.SearchRq request);

}
