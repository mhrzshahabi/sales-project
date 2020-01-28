package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.GlossaryDTO;

import java.util.List;

public interface IGlossaryService {

	GlossaryDTO.Info get(Long id);

	List<GlossaryDTO.Info> list();

	GlossaryDTO.Info create(GlossaryDTO.Create request);

	GlossaryDTO.Info update(Long id, GlossaryDTO.Update request);

	void delete(Long id);

	void delete(GlossaryDTO.Delete request);

	TotalResponse<GlossaryDTO.Info> search(NICICOCriteria criteria);
}
