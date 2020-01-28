package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.LMEDTO;

import java.util.List;

public interface ILMEService {

	LMEDTO.Info get(Long id);

	List<LMEDTO.Info> list();

	LMEDTO.Info create(LMEDTO.Create request);

	LMEDTO.Info update(Long id, LMEDTO.Update request);

	void delete(Long id);

	void delete(LMEDTO.Delete request);

	TotalResponse<LMEDTO.Info> search(NICICOCriteria criteria);
}
