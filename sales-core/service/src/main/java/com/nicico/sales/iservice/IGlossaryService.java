package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.GlossaryDTO;

import java.util.List;

public interface IGlossaryService {

	GlossaryDTO.Info get(Long id);

	List<GlossaryDTO.Info> list();

	GlossaryDTO.Info create(GlossaryDTO.Create request);

	GlossaryDTO.Info update(Long id, GlossaryDTO.Update request);

	void delete(Long id);

	void delete(GlossaryDTO.Delete request);

	SearchDTO.SearchRs<GlossaryDTO.Info> search(SearchDTO.SearchRq request);
}
